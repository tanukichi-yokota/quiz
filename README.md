# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<!-- AWSにSSH接続 -->
ssh -i yokota_aws_key_0914_0530.pem ec2-user@13.208.70.164
<!-- nginx起動 -->
sudo service nginx start
<!-- pricompile -->
bundle exec rails assets:precompile RAILS_ENV=production
<!-- puma起動 -->
bundle exec rails s -e production