class AddPartialIndexToUsersFirstName < ActiveRecord::Migration
  def up
    add_index :users, :first_name, where: "first_name is NOT NULL"
  end

  def down
    remove_index :users, :first_name, where: "first_name is NOT NULL"
  end
end
