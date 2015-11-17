class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|

      t.string :letter
      t.references :game

      t.timestamps null: false
    end

    add_index :turns, :game_id
  end
end
