class RenameContentVars < ActiveRecord::Migration
  def self.up
    rename_column :requests, :owner_id, :content_owner_id
    rename_column :requests, :sender_id, :requester_id
  end

  def self.down
  end
end
