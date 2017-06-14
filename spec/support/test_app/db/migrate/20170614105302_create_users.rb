class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email, null: false
      t.text :first_name
      t.text :last_name

      t.timestamps null: false
    end
  end
end
