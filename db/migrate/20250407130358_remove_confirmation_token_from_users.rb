class RemoveConfirmationTokenFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_index :users, :confirmation_token if index_exists?(:users, :confirmation_token)
    remove_column :users, :confirmation_token, :string if column_exists?(:users, :confirmation_token)
  end
end
