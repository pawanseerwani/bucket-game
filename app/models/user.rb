class User < ActiveRecord::Base
	self.primary_key = :id
	has_many :sessions
	after_initialize :init

	def init
		self.high_score ||= 0
		self.number_of_games_played ||= 0
	end
end
