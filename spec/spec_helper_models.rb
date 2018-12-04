require "active_record"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :dummies do |t|
  t.string :name
  t.string :slug
  t.timestamps null: false
end
