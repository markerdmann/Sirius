class HomeController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @user = current_user
    if !@user.access_token
      scope = 'http://www.google.com/calendar/feeds/'
      next_url = 'http://siriusly.herokuapp.com/google/callback'
      secure = false  # set secure = true for signed AuthSub requests
      sess = true
      @authsub_link = GData::Auth::AuthSub.get_url(next_url, scope, secure, sess)
    end
  end
  
  def google_callback
    client = GData::Client::DocList.new
    @user = current_user
    client.authsub_token = params[:token]
    @user.access_token = client.auth_handler.upgrade()
    @user.save
    redirect_to :action => :index
  end

end
