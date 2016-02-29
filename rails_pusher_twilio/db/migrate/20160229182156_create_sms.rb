class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :from_number
      t.string :timestamp
      t.string :text

      t.timestamps null: false
    end
  end
end
