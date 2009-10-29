namespace :twitter do
  
  desc "Show log of most recent searches"
  task :log => :environment do
    Search.all.each do |sr|
      puts "#{sr.id} (#{sr.created_at}): #{sr.candidates} candidates, #{sr.matched} matched."
    end
  end
  
  desc "Check to see how shitty the search API is today."
  task :bughunt => :environment do
    most_recent = Search.last
    term = "poidh OR \"pics or it didn't happen\" OR \"pics or it didnt happen\""
    ts = Twitter::Search.new(term).since(most_recent.most_recent_seen)
    puts "Twitter sees #{(ts.count==0) ? "ZERO" : ts.count} candidates since #{most_recent.created_at}! (compare with webpage)"
  end
  
  desc "Spider and add new updates to the database"
  task :spider => :environment do
    #TODO: move me to a config file
    key = 'COxdySaiqfjiyX4DaG9A'
    secret = 'Yh0kpGj6bA5A43SRg6TrVmMA7oVRo1zGvjKySi2AM'
    oauth = Twitter::OAuth.new(key, secret)
    client = Twitter::Base.new(oauth)
    term = "poidh OR \"pics or it didn't happen\" OR \"pics or it didnt happen\""
    
    
    #most_recent = Tweet.find(:first, :order => 'observer_msg_timestamp DESC', :limit => 1)
    most_recent = Search.last
    if most_recent.nil? #nothing in database yet
      most_recent_id = 0
      ts = Twitter::Search.new(term)
    else
      most_recent_id = most_recent.most_recent_seen
      #ts = Twitter::Search.new(term).since(most_recent.most_recent_seen)
      #REVERT goddamnit, twitter search API is so broken right now that above is always returning zero results
      #instead, we're just going to pull the most recent EVERY TIME and waste a shitload of API calls, sigh
      ts = Twitter::Search.new(term)
    end
    matched, rejected_private, rejected_not_reply, rejected_already_indexed = 0,0,0,0
    
    puts "#{ts.count} search results since last timestamp to evaluate..."
    #if ts.count > 0
      ts.each do |r|
        #sanity check, is the tweet already in our dataset? (checking DB is faster than making more API calls)
        #if !Tweet.find_by_observer_msg_id(r.id)
        #REVERT since we are doing things the shitty way now, instead we just see if it's newer than we've seen before
        if (r.id > most_recent_id)
          #get the details of both tweets
          begin
            observer = client.status(r.id) 
            #TODO: it'd be awesome for efficiency if we got reply status back above without having to hit REST API, 
            # so need to bug Ryan about this since search api sucks.
            if observer.in_reply_to_status_id.nil?
              puts "[---: Candidate tweet was not in_reply to another tweet.]"
              rejected_not_reply+=1
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
              matched+=1
            end
          rescue
            puts "[---: Private culprit tweet, observer ignored.]"
            rejected_private+=1
          end
        else
          puts "[***: Update already in database (or older).]"
          rejected_already_indexed+=1
        end    
      end
      sr = Search.new(
        :candidates => ts.count,
        :matched => matched,
        :rejected_already_indexed => rejected_already_indexed,
        :rejected_private => rejected_private,
        :rejected_not_reply => rejected_not_reply,
        :most_recent_seen => (ts.first.nil? ? most_recent.most_recent_seen : ts.first.id)
      )
      sr.save
    #end
  end
  
end