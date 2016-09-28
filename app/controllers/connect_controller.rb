class ConnectController < ApplicationController

  require 'soundcloud'

  def login_message
  end

  def login
    client = SoundCloud.new({ client_id: ENV['SOUNDCLOUD_CLIENT_ID'],
                              client_secret: ENV['SOUNDCLOUD_CLIENT_SECRET'],
                              redirect_uri: environment_url })
    redirect_to client.authorize_url(scope: 'non-expiring')
  end

  def verify
    client = SoundCloud.new({ client_id: ENV['SOUNDCLOUD_CLIENT_ID'],
                              client_secret: ENV['SOUNDCLOUD_CLIENT_SECRET'],
                              redirect_uri: environment_url })
    code = params[:code]
    access_token_hash = client.exchange_token(:code => code)
    session[:access_token_hash] = access_token_hash
    redirect_to new_drop_path
  end

  private

  def environment_url
    Rails.env.development? ? "http://localhost:3000/verify" : "https://sounddrop-absolventa.herokuapp.com/verify"
  end

end
