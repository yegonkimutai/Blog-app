class AddBioToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_photo, :string
    add_column :users, :user_bio, :string
  end
end
