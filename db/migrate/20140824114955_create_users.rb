class CreateUsers < ActiveRecord::Migration
	 def change
    create_table :users , { :id => false, :primary_key => :id} do |t| 
    	t.integer :id
    	t.timestamp :last_game_played_at_time
    	t.integer :high_score
    	t.integer :number_of_games_played

      t.timestamps
    end
  end
end
