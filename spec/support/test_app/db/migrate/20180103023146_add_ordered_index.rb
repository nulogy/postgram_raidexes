class AddOrderedIndex < ActiveRecord::Migration
  def up
    add_index :users, :last_name, order: { last_name: "DESC" }
  end

  def down
    remove_index :users, :last_name, order: { last_name: "DESC" }
  end
end
