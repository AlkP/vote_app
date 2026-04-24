class CreateApartments < ActiveRecord::Migration[8.1]
  def change
    create_table :apartments do |t|
      t.string :number, null: false, index: true
      t.string :prefix
      t.string :name
      t.boolean :fragmented, null: false, default: false
      t.float :area, precision: 5, scale: 2

      t.references :parent_apartment, foreign_key: { to_table: :apartments }, index: true

      t.timestamps
    end
  end
end
