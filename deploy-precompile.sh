#!/bin/bash

USER=root
HOST=skliarov.com
SSH_PORT=1235
APP_DIRECTORY=/www/skliarov.com

# Stop Nginx
ssh -p $SSH_PORT $USER@$HOST << ONE
  # Stop nginx server
  echo "/opt/nginx/sbin/nginx -s quit"
  /opt/nginx/sbin/nginx -s quit
ONE

# Upload source code to server
# - avz                     - archive mode, increase verbosity, compress file data during the transfer
# --delete                  - delete extraneous files from destination dirs
# --filter=':- .gitignore'  - excluding files which are indicated in'.gitignore'
# -e "ssh -p 1235"          - user specified port
rsync -avz --filter=':- .gitignore' --exclude='.git' --exclude='deploy.sh' --exclude='deploy-precompile.sh' --delete  -e "ssh -p $SSH_PORT" ./ $USER@$HOST:$APP_DIRECTORY

ssh -p $SSH_PORT $USER@$HOST << TWO
  # Go to Rails app directory
  cd $APP_DIRECTORY
  
  # Update bundle
  RAILS_ENV=production bundle install --without development test
  
  # Install yarn packages
  RAILS_ENV=production yarn
  
  # Run migrations and seed database
  RAILS_ENV=production bundle exec rake db:migrate
  RAILS_ENV=production bundle exec rake db:seed
  
  # Clear Rails app (logs, temp files, precompiled assets)
  RAILS_ENV=production bundle exec rake log:clear
  RAILS_ENV=production bundle exec rake tmp:clear
  rm -rf public/assets
  
  # Precompile assets
  RAILS_ENV=production bundle exec rake assets:precompile
  
  chmod -R 777 ./tmp
  
  # Start Nginx server
  sudo /opt/nginx/sbin/nginx
TWO
