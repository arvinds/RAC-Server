class User < ActiveRecord::Base
  has_many :requests_made, :class_name => "Request", :foreign_key => "requester_id"
  has_many :requests_given, :class_name => "Request", :foreign_key => "content_owner_id"

  has_many :contents

  validates_uniqueness_of :guid

  acts_as_authentic do |c|
    c.validates_length_of_login_field_options = {:if => "false", :minimum => 4}
    c.validates_length_of_email_field_options = {:if => "false", :minimum => 4}
    c.validates_confirmation_of_password_field_options = {:if => "true"}
    c.validates_length_of_password_field_options = {:if => "false", :minimum => 4 }
    c.validates_confirmation_of_password_field_options = {:if => "true"}
    c.validates_length_of_password_confirmation_field_options = {:if => "false", :minimum => 4 }
  end
  
  def name
    return first_name + " " + last_name
  end

  def self.create_user(guid,fname,lname,email,fbid)
    guid ||= ""
    user = User.new()
    user.guid = guid
    user.first_name = fname
    user.last_name = lname
    user.email = email
    user.fbid = fbid
    user.user_type = 1
    user.save!
    return user.id
  end

  def isFBUser?
    return user_type == 1 
  end
end
