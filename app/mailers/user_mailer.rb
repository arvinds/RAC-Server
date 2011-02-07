class UserMailer < ActionMailer::Base
  default :from => "notifications@saucers.cups.cs.cmu.edu"
  
  def request_notification_email(request)
    @owner = request.content_owner
    @requester = request.requester
    @url  = url_for(:host =>"saucers.cups.cs.cmu.edu:3000", :controller => 'requests', :action => 'edit', :id => request.id)
    @user_show_url  = user_url(@owner, :host =>"saucers.cups.cs.cmu.edu:3000")
    mail(:to => @owner.email,
         :subject => "You have a request from " + @requester.name)
  end
end
