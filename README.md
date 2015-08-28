# Deployment

If you want to deployment manually instead of using Docker,
Please follow these steps.

## Setup postgres server

Install packages:

    # pacman -Syy
    # pacman -S postgresql

Setup database:

    # Run these commands as `postgres` user:
    $ initdb --locale en_US.UTF-8 -E UTF8 -D $data
    $ export port=... # your database port
    $ export user=... # your database user
    $ export pass=... # your database password
    $ export name=... # your database name
    $ export data=/var/lib/postgres/data
    $ postgres -p $port -D $data &
    $ pid=$!
    $ sleep 3
    $ echo "CREATE USER $user WITH PASSWORD '$pass'" | psql
    $ createdb -O $user $name
    $ kill -s TERM $pid
    $ wait $pid
    $ echo "host all all 0.0.0.0/0 md5" >> $data/pg_hba.conf
    $ echo "listen_addresses = '*'" >> $data/postgresql.conf
    $ exec postgres -p $port -D $data

## Setup web server

Install packages:

    # pacman -Syy
    # pacman -S ruby postgresql

Install essential gems:

    $ gem install bundler foreman

Configure the database.yml

    $ vim config/database.yml
    <%= ENV['RACK_ENV'] %>:
      host: <%= ENV['DB_HOST'] %>
      port: <%= ENV['DB_PORT'] %>
      username: <%= ENV['DB_USER'] %>
      password: <%= ENV['DB_PASS'] %>
      database: <%= ENV['DB_NAME'] %>
      adapter: <%= ENV['DB_ADAP'] %>

Install gems:

    $ bundle install --deployment

Precompile the assets:

    $ bundle exec rake assets:precompile

Setup database:

    $ bundle exec rake db:migrate

Setup the web server:

    $ export HOME=/path/to/home
    $ export DOMAIN=your.domain.com
    $ export PORT=... # eg: 443
    $ export RACK_ENV=production
    $ export RAILS_ENV=production
    $ export SECRET_KEY_BASE=... # eg: f5efe5b9a0e69e512310e761f8ce116383c71084db8ce8e54745b893f265d7bc1983009cfe81a45542c2f9d748aab947f64f93e4ed8635c7e761cbafebf79e3a
    $ export SSL_ADDR=0.0.0.0
    $ export SSL_CRT=/path/to/server.crt
    $ export SSL_KEY=/path/to/server.key
    $ export SENDGRID_USERNAME=... # your sendgrid username
    $ export SENDGRID_PASSWORD=... # your sendgrid password
    $ export DB_HOST=... # your database address
    $ export DB_PORT=... # your database port
    $ export DB_USER=... # your database user
    $ export DB_PASS=... # your database password
    $ export DB_NAME=... # your database name
    $ export DB_ADAP=postgresql
    $ foreman start -c -f Procfile -d .

# Development

Setup database:

    $ export user=... # your database user
    $ export pass=... # your database password
    $ export name=... # your database name
    $ echo "CREATE USER $user WITH PASSWORD '$pass'" | psql
    $ createdb -O $user $name

Install gems:

    $ bundle install

Setup database:

    $ bundle exec rake db:migrate

Setup the web server:

    $ export MAILTRAP_ADDRESS="mailtrap.io"
    $ export MAILTRAP_PORT="2525"
    $ export MAILTRAP_DOMAIN="mailtrap.io"
    $ export MAILTRAP_AUTHENTICATION="cram_md5"
    $ export MAILTRAP_USER_NAME=... # your mailtrap username
    $ export MAILTRAP_PASSWORD=...  # your mailtrap password
    $ export SSL_ADDR="127.0.0.1"
    $ export SSL_KEY="/path/to/server.key"
    $ export SSL_CRT="/path/to/server.crt"
    $ bundle exec puma -C config/puma.rb
    [24642] Puma starting in cluster mode...
    [24642] * Version 2.12.2 (ruby 2.3.0-p-1), codename: Plutonian Photo Shoot
    [24642] * Min threads: 5, max threads: 5
    [24642] * Environment: development
    [24642] * Process workers: 2
    [24642] * Preloading application
    [24642] * Listening on ssl://127.0.0.1:3000?cert=/path/to/server.crt&key=/path/to/server.key
    [24642] Use Ctrl-C to stop
    [24642] - Worker 0 (pid: 24646) booted, phase: 0
    [24642] - Worker 1 (pid: 24654) booted, phase: 0
