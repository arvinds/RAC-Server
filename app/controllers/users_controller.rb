class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.save do |result|
        if result
          flash[:notice] = "Account registered!"
          redirect_back_or_default user_path @user
        else
          render :action => :new
        end
    end
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
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_path @user
    else
      render :action => :edit
    end
  end
end
