class AddFbIdField < ActiveRecord::Migration
  def self.up
    add_column :users, :fbid, :string
  end

  def self.down
  end
end
