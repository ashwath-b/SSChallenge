class AddValidEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :valid_email, :boolean, :default => false
  end
end
