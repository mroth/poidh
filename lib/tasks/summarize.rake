namespace :summarize do
  
  desc "Dump all the tweets into a single output"
  task :dump => :environment do
    Tweet.all.each do |t|
      puts t.culprit_msg
    end
  end
  
end