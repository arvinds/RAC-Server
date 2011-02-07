class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :guid
      t.string :last_name, :null => false
      t.string :first_name, :null => false
      t.string :email, :null => false
      t.string :persistence_token, :null => false
      t.string :password_salt, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
