class User < ActiveRecord::Base
#  has_many :requests_made, :class_name => "OwnerUserRequest", :foreign_key => "user_id"
#  has_many :requests_given, :class_name => "RequesterUserRequest", :foreign_key => "user_id"
  has_many :requests_made, :class_name => "Request", :foreign_key => "requester_id"
  has_many :requests_given, :class_name => "Request", :foreign_key => "content_owner_id"

  has_many :contents

  acts_as_authentic do |c|
  end
  
  def name
    return first_name + " " + last_name
  end
end
