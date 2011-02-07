class Content < ActiveRecord::Base
  has_many :requests
  belongs_to :content_owner, :class_name => "User", :foreign_key => "user_id"
end
