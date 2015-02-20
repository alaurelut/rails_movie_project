class UsersMoviesController < ApplicationController

	def list

  		if params[:todo] == 'to_see'
			to_see = 1
			seen = 0
			movie_state = UserMovie.where("seen = 1 AND user_id = ? AND movie_id = ? ", current_user.id, params[:movie_id] )
		else
		   	to_see = 0
		   	seen = 1
		   	movie_state = UserMovie.where("to_see = 1 AND user_id = ? AND movie_id = ? ", current_user.id, params[:movie_id] )
		end

		if params[:todo]

			if movie_state.size != 0
				movie_state.update_all({:to_see => to_see, :seen => seen})
			else
				create = UserMovie.create(user_id: current_user.id, movie_id: params[:movie_id], seen: seen, to_see: to_see)
			end
		end

		@users_movies_to_see = UserMovie.where("to_see = 1 AND user_id = ?", current_user.id)
		@users_movies_seen = UserMovie.where("seen = 1 AND user_id = ?", current_user.id)
		   
		@movies_to_see = []
		@movies_seen = []

		@users_movies_to_see.each { |item| 
        	@movies_to_see << Movie.where("movie_id = ?",item.movie_id)
	    }

	    @users_movies_seen.each { |item| 
        	@movies_seen << Movie.where("movie_id = ?",item.movie_id)
	    }

	end

end