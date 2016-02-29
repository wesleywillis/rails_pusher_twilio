class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :from_number
      t.string :timestamp
      t.string :text

      t.timestamps null: false
    end
  end
end
