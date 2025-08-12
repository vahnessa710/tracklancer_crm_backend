class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.references :client, null: false, foreign_key: true
      t.string :title
      t.integer :status
      t.decimal :price
      t.date :due_date

      t.timestamps
    end
  end
end
