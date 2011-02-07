class AddPasswordToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :crypted_password, :string, :null => false                # optional, see below

  end

  def self.down
  end
end
