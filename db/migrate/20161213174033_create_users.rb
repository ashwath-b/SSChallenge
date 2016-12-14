class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :confirmation_token
      t.boolean :confirmed

      t.timestamps
    end
  end
end
