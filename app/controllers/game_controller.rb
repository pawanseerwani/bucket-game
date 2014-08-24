class GameController < ApplicationController

	# Only for testing
	skip_before_action :verify_authenticity_token

  def index

  end

  def get_user
  	create_user unless check_user

  	response = {
  		user_id: @user.id,
  		last_played: @user.last_game_played_at_time,
  		high_score: @user.high_score,
  		no_of_games: @user.number_of_games_played
  	}
  	render :json => response, :status => :ok
  end

  def update_score
  	@game_params = filter_params
  	user_id = cookies[:user_id]
  	#user_id = params[:user_id]
  	@user = User.find(user_id) rescue nil
  	if @user
  		create_session_record
  		update_user
  		render :json => { msg: "Updated Successfully" }, :status => :ok
  	else
  		render :json => { msg: "User not found" }, :status => :not_found
  	end
  end

  private

  def create_user
  	@user = User.new
  	@user.id = DateTime.now
  	@user.save

  	cookies[:user_id] = @user.id
  end

  def check_user
  	@user = User.find(cookies[:user_id]) rescue nil
  end

  def filter_params
  	params.permit(:score)
  end

  def create_session_record
  	session = Session.new
  	session.user_id = @user.id
  	session.score = @game_params[:score]
  	session.save
  end

  def update_user
  	@user.last_game_played_at_time = DateTime.now
  	@user.high_score = @game_params[:score] if @game_params[:score].to_i > @user.high_score
  	@user.number_of_games_played += 1
  	@user.save
  end

end
