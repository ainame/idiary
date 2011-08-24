require 'rubygems'    # ←Ruby 1.9では不要
require 'twitter'
require 'pp'
class TwitterController < ActionController::Base

  define test
     # your app
      oauth = Twitter::OAuth.new('RZb8v1lbXJAzeBSA6KWQ', 'Mc6NEpxhhsUJpUTmKCh7Gt8o0DcbwNLNBnw3WoVq2SQ')
      # your login
      oauth.authorize_from_access('96814807-u3S4EgNlURQrUt8o2kjYQtTKp2SqzXgIa0zuszqgv', 'MJhdy72I2qj7gOErc5lXhaGfP6uuZ70uPConlGcM')
      twitter = Twitter::Base.new(oauth)
      
      pp twitter.user_timeline
  end
end