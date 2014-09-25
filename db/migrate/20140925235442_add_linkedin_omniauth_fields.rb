class AddLinkedinOmniauthFields < ActiveRecord::Migration
  def change
    add_column :users, :image, :string, default: ""
    add_column :users, :location, :hstore, default: {}
    add_column :users, :name, :string, null: false
    add_column :users, :token, :string, null: false
  end
end
