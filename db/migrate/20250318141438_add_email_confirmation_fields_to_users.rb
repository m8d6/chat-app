class AddEmailConfirmationFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_confirmed, :boolean, default: false unless column_exists?(:users, :email_confirmed)
    add_column :users, :email_verified_at, :datetime unless column_exists?(:users, :email_verified_at)
    
    unless index_exists?(:users, :confirmation_token, unique: true)
      add_index :users, :confirmation_token, unique: true
    end
  end
end
