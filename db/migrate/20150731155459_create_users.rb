class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.integer :inbox_total
      t.integer :inbox_unread
      t.integer :inbox_not_responded
      t.string :authentication_token
      t.string :profile_image_url

      t.timestamps null: false
    end
  end
end
