class ApplicationController < ActionController::Base
  #protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user

  private
      def current_user_session
        return @current_user_session if defined?(@current_user_session)
        @current_user_session = UserSession.find
      end

      def current_user
        return @current_user if defined?(@current_user)
        @current_user = current_user_session && current_user_session.user
        return @current_user
      end
      def require_user
        unless current_user
          store_location
          flash[:notice] ||= "Please login!"
          redirect_to landing_path
          return false
        end
      end

    def require_no_user(redir_path = logout_path)
      if current_user
        store_location
        redirect_back_or_default(redir_path)
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(default || session[:return_to])
      session[:return_to] = nil
    end

  def check_guid_set
    unless current_user.nil? 
      if current_user.guid.blank?
        redirect_to url_for(:controller =>:users, :action => :edit, :id=>current_user.id)
      end
    end
  end


end
