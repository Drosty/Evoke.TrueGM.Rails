class AddGameKeyToNflMatchup < ActiveRecord::Migration
  def change
    add_column :nfl_matchups, :game_key, :string, index: true
  end
end
