class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :code
      t.integer :from_id
      t.integer :to_id
      t.string :duration
      t.string :departure
      t.string :arrival

      t.timestamps
    end
    add_index :flights, :from_id
    add_index :flights, :to_id
  end
end
