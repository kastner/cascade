set :application, "cascade.metaatem.net"
set :domain, "metaatem"

role :app, domain
role :web, domain
role :db, domain, :primary => true

set :user, "kastner"
set :group, "www-data"
set :deploy_to, "/var/www/cascade"
set :deploy_via, :remote_cache

default_run_options[:pty] = true

# scm settings
set :repository, "git://github.com/kastner/cascade.git"
set :scm, "git"
set :branch, "master"
set :git_enable_submodules, 1

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  task :after_update_code, :roles => :app, :except => {:no_symlink => true} do
    run <<-CMD
      cd #{release_path} &&
      ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/db/
    CMD
  end
end
