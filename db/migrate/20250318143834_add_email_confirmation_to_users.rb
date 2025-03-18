class AddEmailConfirmationToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :confirmation_token, :string
    add_index :users, :confirmation_token
    add_column :users, :email_confirmed, :boolean
    add_column :users, :email_verified_at, :datetime
  end
end
