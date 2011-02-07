class AddNameToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :name, :string , :null => false
  end

  def self.down
  end
end
