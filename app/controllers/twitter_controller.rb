class TwitterController < ApplicationController

  def index
  end

  def login
	oauth.set_callback_url("http://#{request.host}#{":#{request.port}" unless request.port ==80}/finalize")
	session[:request_token] = oauth.request_token.token
	session[:request_secret] = oauth.request_token.secret
	
	redirect_url = oauth.request_token.authorize_url
	redirect_url = "http://" + redirect_url unless redirect_url.match(/^http:\/\//)
	redirect_to redirect_url
	
  end

  def finalize
	oauth.authorize_from_request(session[:request_toke], session[:request_secret], params[:oauth_verifier])
	@profile = Twitter::base.new(oauth).verify_credentials
	session[:request_token] = nil
	session[:request_secret] = nil
	@auth_token = session[:auth_token] = oauth.access_token.token
	session[:auth_secret] = oauth.access_token.secret
	
  end
  
  private 
  
  def oauth
	  @oauth ||= Twitter::oAuth.new(APP_CONFIG[:twitter][:consumer_key],APP_CONFIG[:twitter][:consumer_secret])
	  #auth = Twitter::OAuth.new(TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET)
      #auth.authorize_from_access(TWITTER_ACCESS_TOKEN, TWITTER_ACCESS_SECRET)
      #client = Twitter::Base.new(auth)
  end
  
  def client
	oauth.authorize_from_access(session[:auth_token], session[:auth_secret])
	Twitter::Base.new(oauth)
  end
  
  def read_status
    @tweets = Tweet.all
    @tweet = Tweet.new

    respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @tweets }
    end

  end
end
