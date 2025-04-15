class ChangeGenderColumnTypeToInteger < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :gender, :integer
    User.where(gender: "male").update_all(gender: 0)
    User.where(gender: "female").update_all(gender: 1)
    User.where(gender: "other").update_all(gender: 2)
  end
end
