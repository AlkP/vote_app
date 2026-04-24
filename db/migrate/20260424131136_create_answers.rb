class CreateAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :answers do |t|
      t.integer :vote, null: false, limit: 1

      t.references :apartment, null: false, foreign_key: true, index: true
      t.references :question, null: false, foreign_key: true, index: true

      t.timestamps
    end

    add_index :answers, [:apartment_id, :question_id], unique: true
  end
end
