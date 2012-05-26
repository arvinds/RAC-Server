class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
#  before_filter :check_guid_set, :except => [:edit]
  
  def new
    require_no_user
    @user = User.new
  end
  
  def create
    require_no_user
    @user = User.new(params[:user])
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:notice] = "Password confirmation does not match!"
      redirect_to :back
    elsif @user.valid?
      @user.save!
      flash[:notice] = "Account registered!"
      redirect_to root_path
    else
      errs = "#{@user.errors.size } Errors:  "
      a = @user.errors.size
      @user.errors.each do |attr,err|
        errs += attr.to_s + " " + err
        if(a > 1)
          errs += ", "
          a-=1
        end
      end
      flash[:notice] = errs
      redirect_to new_user_path
    end
  end
  
  def login_show
  end

  def show
    @user = current_user
    @user = User.find(params[:id]) unless !defined?(params[:id]) || params[:id].nil?
      
    if current_user != @user
      redirect_to '/logout'
    else
      @user
      @requests_given = @user.requests_given
      @requests_made = @user.requests_made
    end
  end

  def edit
    @user = current_user
    @user = User.find(params[:id]) unless !defined?(params[:id]) || params[:id].nil?
    if current_user != @user
      redirect_to '/logout'
    else
      @user
    end
  end
  
  def update
    @user = @current_user 
    if params[:user][:guid] == ""
      flash[:notice] = "Please set a GUID"
      render :action => :edit
    elsif (!@user.isFBUser? &&  # not a fb user
          (params[:user][:password].nil? || params[:user][:password_confirmation].nil? || params[:user][:password] != params[:user][:password_confirmation])) # password issue
      flash[:notice] = "Password confirmation does not match!"
      redirect_to edit_user_path
    elsif @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_path @user
    else
      render :action => :edit
    end
  end

  def destroy
    User.find(params[:id]).delete
    redirect_to landing_path
  end
end
