class Request < ActiveRecord::Base
    belongs_to :requester, :class_name =>"User"
    belongs_to :content_owner, :class_name => "User"
    belongs_to :content

  def get_status
    return case status
      when 0 then "pending" #pending
      when 1 then "pending" #ignore
      when 2 then "approved" #approve
      when 3 then "rejected" #reject
    end 
  end

  def get_masked_status
    return nil if status.nil?
    return case status
      when 0 then 0 
      when 1 then 0
      when 2 then 1
      when 3 then 2
    end 
  end
end
