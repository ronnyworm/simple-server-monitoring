#!/usr/bin/env ruby
# encoding: utf-8

# ⚠️ WARNING, CONTAINS CREDENTIALS ⚠️

require 'mail'

smtp_host = 
smtp_port = 
smtp_user =
smtp_pass = 
target_mail = 

options = { :address              => smtp_host,
            :port                 => smtp_port,
            :user_name            => smtp_user,
            :password             => smtp_pass,
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end

# maybe you don't want from to be the same as smtp_user, change as needed
Mail.deliver do
       to target_mail
     from smtp_user
  subject 'Server Monitoring'
     body "#{ARGV[0]}"
end
