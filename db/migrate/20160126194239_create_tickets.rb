class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :body
      t.integer :user_id
      t.integer :assignee_id
      t.string :severity

      t.timestamps null: false
    end
  end
end
