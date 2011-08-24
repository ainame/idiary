require 'twitter'
require 'pp'
class TwitterController < ActionController::Base

  def test
    Twitter.configure do |config|
      config.consumer_key = 'RZb8v1lbXJAzeBSA6KWQ'
      config.consumer_secret = 'Mc6NEpxhhsUJpUTmKCh7Gt8o0DcbwNLNBnw3WoVq2SQ'
      config.oauth_token = '96814807-u3S4EgNlURQrUt8o2kjYQtTKp2SqzXgIa0zuszqgv'
      config.oauth_token_secret = 'MJhdy72I2qj7gOErc5lXhaGfP6uuZ70uPConlGcM'
    end
    @line=Twitter.user_timeline("ainame")
  end
end