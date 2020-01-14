class CreateShips < ActiveRecord::Migration[5.2]
  def up
    create_table :ships do |table|
      table.string :name, null: false
      table.string :ship_class, null: false
      table.string :location, null: false
    end
  end

  def down
    drop_table :ships
  end
end
