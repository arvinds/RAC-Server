class RequestsController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]

  # GET /requests/1
  # GET /requests/1.xml

  # POST /requests
  # POST /requests.xml
  def create
#    success = true
#    begin
        @content = Content.find_by_guid(params[:content_guid])
        unless @content
          @content = Content.new
          @content.name = params[:content_name]
          @content.name ||= "no name provided"
          @content.guid = params[:content_guid]
          @content.content_owner = User.find_by_guid(params[:owner_guid])
        end

        @request = Request.new()
        @request.content = @content
        @request.content_owner = User.find_by_guid(params[:owner_guid])
        @request.requester = User.find_by_guid(params[:requester_guid])
        @request.status = 0; #0-4 not acted on, ignore, accept, reject
        @request.action = Action.find(params[:action_id]);
=begin
    rescue
      success = false
    end
=end

    if  @content.save && @request.save
      UserMailer.request_notification_email(@request).deliver
      render :text => "request created\n" #, :status => 201  created 
    else
      render :text => "request not created\n", :status => :unprocessable_entity
    end
  end

  def edit
    @request = Request.find(params[:id])
    if @request && current_user == @request.content_owner
      @request
    else
      render :text => "You are not allowed to access this request."
    end
  end

  # PUT /requests/1
  # PUT /requests/1.xml
  def update 
    @request = Request.find(params[:id])
    @request.status = params[:response];
    if @request.content_owner != current_user || params[:action == 0]
      render :html => "Not your request!"
    else
        respond_to do |format|
          if @request.save
            format.html { redirect_to(user_path @current_user, :notice => 'Request was successfully updated.') }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @request.errors, :status => :unprocessable_entity }
          end
        end
    end
  end

=begin
  # DELETE /requests/1
  # DELETE /requests/1.xml
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to(requests_url) }
      format.xml  { head :ok }
    end
  end
=end
end
