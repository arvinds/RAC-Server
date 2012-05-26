class RequestsController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]
#  before_filter :check_guid_set, :except => [:edit, :update]


  # GET /requests/1
  # GET /requests/1.xml

  # POST /requests
  # POST /requests.xml
  def create
    success = true
    begin
        @content = Content.find_by_guid(params[:content_guid])
        unless @content
          require 'base64'
          @content = Content.new
          @content.name = params[:content_name]
          @content.name ||= "no name provided"
          @content.guid = params[:content_guid]
          @content.metadata = params[:content_metadata]
        end

        @request = Request.new()
        @request.content = @content
        @request.content_owner = User.find_by_guid(params[:owner_guid])
        @request.requester = User.find_by_guid(params[:requester_guid])
        @request.status = 0; #0-4 not acted on, ignore, accept, reject
        @request.action = params[:action_name]

        require 'digest/sha2'
        begin
          req_guid = Digest::SHA2.hexdigest((rand * rand * rand + rand * rand + rand).to_s)
        end while not Request.find_by_guid(req_guid).nil?
        @request.guid = req_guid
        success = @content.save && @request.save

    rescue Exception => e
      puts e.to_s
      success = false
    end

    if success
      UserMailer.request_notification_email(@request).deliver
      require 'base64'
      image_data = Base64.decode64 params[:content_image]
      f = File.new("#{Rails.root}/public/images/#{@request.id}.gif",'wb')
      f.write(image_data)
      f.close
      render :text => "request created\n#{req_guid}" #, :status => 201  created 
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
    @request.obligation_text = params[:obligation_text]
#    @request.obligation_date = DateTime.strptime(params[:obligation_date], "%B %d, %Y %I:%M %p")
    @request.obligation_date = nil
    @request.status = params[:response]
    if @request.content_owner != current_user || params[:action == 0]
      render :html => "Not your request!"
    elsif @request.save
        redirect_to(user_path @current_user, :notice => 'Request was successfully updated.')
    else
        render :action => "edit"
    end
  end

  def show
    if params['id'].to_s == "999"
      render :text => [0,1,2,-1][rand(4)] 
    else

        @request = Request.find_by_guid(params['id']) 
        if @request
          status = @request.get_masked_status.to_s
          obl_text = @request.obligation_text
          obl_date = @request.obligation_date
          render :text => "#{status}\n#{obl_text}\n#{obl_date}"
        else
          render :text => "-1"
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
