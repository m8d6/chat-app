class AddEmailConfirmationToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_confirmed, :boolean, default: false
    add_column :users, :email_verified_at, :datetime

    add_index :users, :confirmation_token, unique: true
  end
end
