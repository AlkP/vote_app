class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.string :name

      t.references :survey, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
