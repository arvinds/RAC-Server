class AddAssociative < ActiveRecord::Migration
  def self.up
    create_table :userrequests do |t|
      t.integer :user_id, :null => false
      t.integer :request_id, :null => false
      t.integer :role, :null => false
    end
  end

  def self.down
  end
end
