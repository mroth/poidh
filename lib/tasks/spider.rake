namespace :twitter do
  desc "Test case"
  task :test do
    puts "test"
  end
  
  desc "Spider and add new updates to the database"
  task :spider => :environment do
    #TODO: move me to a config file
    key = 'COxdySaiqfjiyX4DaG9A'
    secret = 'Yh0kpGj6bA5A43SRg6TrVmMA7oVRo1zGvjKySi2AM'
    oauth = Twitter::OAuth.new(key, secret)
    client = Twitter::Base.new(oauth)
    
    most_recent = Tweet.find(:first, :order => 'observer_msg_timestamp DESC', :limit => 1).observer_msg_id
    ts = Twitter::Search.new('POIDH').since(most_recent)
    puts "#{ts.count} search results since last timestamp to evaluate..."
    ts.each do |r|
      #sanity check, is the tweet already in our dataset? (checking DB is faster than making more API calls)
      if !Tweet.find_by_observer_msg_id(r.id)
        #get the details of both tweets
        begin
          observer = client.status(r.id) 
          #TODO: it'd be awesome for efficiency if we got reply status back above without having to hit REST API, 
          # so need to bug Ryan about this since search api sucks.
          if observer.in_reply_to_status_id.nil?
            puts "[---: Candidate tweet was not in_reply to another tweet.]"
          else
            culprit = client.status(observer.in_reply_to_status_id.to_i)
            puts "[+++: #{observer.user.screen_name} wants pix of #{observer.in_reply_to_screen_name}!]"
            
            #store it into db
            t = Tweet.new(
              :observer_id => observer.user.id,
              :observer_screen_name => observer.user.screen_name,
              :observer_avatar_url => observer.user.profile_image_url,
              :observer_msg_id => observer.id,
              :culprit_id => culprit.user.id,
              :culprit_screen_name => culprit.user.screen_name,
              :culprit_avatar_url => culprit.user.profile_image_url,
              :culprit_msg_id => culprit.id,
              :observer_msg_timestamp => observer.created_at,
              :culprit_msg_timestamp => culprit.created_at,
              :observer_msg => observer.text,
              :culprit_msg => culprit.text
            )
            t.save
          end
        rescue
          puts "[---: Private culprit tweet, observer ignored.]"
        end
      else
        puts "[***: Update already in database.]"
      end    
    end
  end
  
end