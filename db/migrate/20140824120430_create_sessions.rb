class CreateSessions < ActiveRecord::Migration
	def change
	    create_table :sessions do |t|
	   	  t.references :user
	      t.integer :score
	    end
  	end
end
