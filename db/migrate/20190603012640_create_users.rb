class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :age, null: false, default: 0
      t.string :name, null: false

      t.timestamps
    end
  end
end
