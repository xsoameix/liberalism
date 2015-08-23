workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

if ENV['SSL_ADDR']
  ssl_bind ENV['SSL_ADDR'], ENV['PORT'] || '3000', {
    key: ENV['SSL_KEY'],
    cert: ENV['SSL_CRT']
  }
else
  port ENV['PORT'] || '3000'
end
