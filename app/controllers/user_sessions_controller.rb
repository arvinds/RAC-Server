require 'json'
require 'mechanize'
require 'digest'
class UserSessionsController < ApplicationController
  helper :all
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
#  before_filter :check_guid_set

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save      
      flash[:notice] = "Login successful!"      
      redirect_to root_path
    else      
      render :action => :new    
    end
  end

  def landing
    @user = current_user
    if @user
      redirect_to user_path(@user) #url_for :controller => :user_sessions, :action => :show, :id => 
    end
  end

  def fb
    app_id = "180262335349534"
    app_secret = "4f3c5980d28c5de2d5f3d2cf53c4de67"
    callback_url = "http://saucers.cups.cs.cmu.edu:3000/fb"


    code = params[:code] 
    error = params[:error] 

    if error
      redirect_to root_path
    elsif code.nil? || code.empty? #init code request
      redirect_to "https://www.facebook.com/dialog/oauth?client_id=#{app_id}&redirect_uri=#{callback_url}&scope=email"
    else #token request
      code = CGI::escape code
      uri = "https://graph.facebook.com/oauth/access_token?"+
      "client_id=#{app_id}&redirect_uri=#{callback_url}&"+
      "client_secret=#{app_secret}&code=#{code}"

      agent = Mechanize.new
      token_data = agent.get(uri).body
      token_part,expire_part = token_data.match(/(.+)&(.+)/).captures
      token = token_part.match(/.+=(.+)/)[1]
      access_token = "?access_token=" + CGI::escape(token)
    
      get_user_uri = "https://graph.facebook.com/me" + access_token
      user_data_txt = agent.get(get_user_uri).body
      user_data = JSON.parse(user_data_txt)
      puts user_data.inspect
      fname = user_data["first_name"]
      lname = user_data["last_name"]
      email = user_data["email"]
      fbid = user_data["id"]
      user = User.find_by_email(email)
      guid = nil
       
      success = false
      if user.nil? # if user is new
        new_id = User.create_user(guid,fname,lname,email,fbid)
        redirect_to url_for(:controller =>:users, :action => :edit, :id=>new_id)
      else # create session for user
        session = UserSession.create(user,true)  
        flash[:notice] = "Login successful!"
        if user.guid.blank?
          redirect_to url_for(:controller =>:users, :action => :edit, :id=>user.id)
        else
          redirect_to root_path
        end
      end
    end
  end


  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default landing_path
  end

end
