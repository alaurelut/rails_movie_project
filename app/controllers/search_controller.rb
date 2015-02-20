class SearchController < ApplicationController
	def search
		@movies = Tmdb::Movie.find(params[:query])
	end
end