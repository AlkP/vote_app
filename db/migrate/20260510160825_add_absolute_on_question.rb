class AddAbsoluteOnQuestion < ActiveRecord::Migration[8.1]
  def change
    add_column :questions, :absolute, :boolean, default: false, null: false
  end
end
