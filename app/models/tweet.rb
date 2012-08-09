class Tweet < ActiveRecord::Base

   
	Twitter.configure do |config|
	  config.consumer_key = TWITTER_CONSUMER_KEY
	  config.consumer_secret = TWITTER_CONSUMER_SECRET
      config.oauth_token =TWITTER_ACCESS_TOKEN
      config.oauth_token_secret = TWITTER_ACCESS_SECRET
	  
    end
	

  def read_text
    return "[sin status]" if self.status.blank?    
	Twitter.status(self.status).text
  end

  def read_message
    return "sin usuario" if self.user.blank?
	Twitter.home_timeline.first.text
    Twitter.user_timeline(self.user).first.text
  end
  
  def update_status
	return "sin update" if self.message.blank?
	Twitter.update(self.message)
  end
  
  def read_status
    #return "[status]" if self.status.blank?    
	Twitter.status(self.status).text
  end
   
end
