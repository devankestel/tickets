class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :category
      t.string :note
      t.integer :ticket_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
