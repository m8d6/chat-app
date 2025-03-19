class AddEmailConfirmationToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :confirmation_token, :string unless column_exists?(:users, :confirmation_token)
    add_column :users, :email_confirmed, :boolean, default: false unless column_exists?(:users, :email_confirmed)
    add_column :users, :email_verified_at, :datetime unless column_exists?(:users, :email_verified_at)
    
    add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
  end
end
