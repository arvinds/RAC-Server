class Request < ActiveRecord::Base
    belongs_to :requester, :class_name =>"User"
    belongs_to :content_owner, :class_name => "User"
    belongs_to :content
    belongs_to :action

  def get_status
    return case status
      when 0 then "pending" #pending
      when 1 then "pending" #ignore
      when 2 then "approved" #approve
      when 3 then "rejected" #reject
    end 
  end
end
