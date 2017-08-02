class AddUsersTrgmIndexes < ActiveRecord::Migration
  def change
    add_index "users", ["email"], name: "index_users_on_email_trigram", using: :gin, opclasses: {"email"=>"gin_trgm_ops"}
    add_index "users", ["last_name"], name: "index_users_on_last_name_trigram", using: :gin, opclasses: {"last_name"=>"gin_trgm_ops"}
  end
end
