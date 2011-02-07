class AddIdsForAssociations < ActiveRecord::Migration
  def self.up
    add_column :requests, :sender_id, :integer, :null => false

    add_column :requests, :owner_id, :integer, :null => false

    add_column :requests, :content_id, :integer, :null => false

    add_column :requests, :action_id, :integer, :null => false
  end

  def self.down
  end
end
