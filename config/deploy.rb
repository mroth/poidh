#dreamhost stuff
set :user, 'mroth'  # Your dreamhost account's username
set :domain, 'poidh.org'  # Dreamhost servername where your account is located 
set :project, 'poidh'  # Your application as its called in the repository
set :application, 'poidh.org'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup

#github stuff
set :repository, "git@github.com:mroth/poidh.git"
set :scm, :git
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

#stuff for local git (from dreamhost cap tutorial)
set :scm_command, "/home/mroth/packages/bin/git" #updated version of git on  server in user directory
set :local_scm_command, "/opt/local/bin/git" #correct path to local git

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir

# additional settings
# default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Users/mroth/.ssh/id_dsa /Users/mroth/.ssh/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

### stuff to snoop on environment vars
desc "Echo environment vars" 
namespace :env do
  task :echo do
    run "echo printing out cap info on remote server"
    run "echo $PATH"
    run "printenv"
  end
end

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

##### stuff from railscasts
namespace :deploy do
  desc "Tell Passenger to restart the app."
  #task :restart do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
  
  #desc "Sync the public/assets directory."
  #task :assets do
  #  system "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{application}:#{shared_path}/"
  #end
  
  # this one added as per http://railscasts.com/episodes/164-cron-in-ruby
  # desc "Update the crontab file"
  # task :update_crontab, :roles => :db do
  #   run "cd #{release_path} && whenever --update-crontab #{application}"
  # end
  
end

after 'deploy:update_code', 'deploy:symlink_shared'
#after "deploy:symlink", "deploy:update_crontab"
