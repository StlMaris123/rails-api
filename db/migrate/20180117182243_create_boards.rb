class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.references :creator, foreign_key: true
      t.string :title
      t.boolean :archived, default: false, null: false

      t.timestamps
    end
  end
end
