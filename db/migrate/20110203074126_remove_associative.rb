class RemoveAssociative < ActiveRecord::Migration
  def self.up
    drop_table :userrequests
  end

  def self.down
  end
end
