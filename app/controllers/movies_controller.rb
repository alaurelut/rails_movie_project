class MoviesController < ApplicationController

  def show
  	@movie = Movie.where("movie_id = ?",params[:id])

	  if @movie.size == 0

     	trailers =  Tmdb::Movie.trailers(params[:id])
      details = Tmdb::Movie.detail(params[:id])

      if trailers.youtube.size != 0

        genres = ""

        details.genres.each_with_index { |item,index| 
          if index == 0
            genres << item.name
          else
            genres << ", "+item.name
          end
        }

        trailer = trailers.youtube[0].source
      else
        trailer = nil
      end

      create = Movie.create(movie_id: params[:id] ,title: details.title, release_date: details.release_date, poster: details.poster_path, genre: genres, description: details.overview, trailer: trailer)

      @movie = Movie.where("movie_id = ?",params[:id])

    end

  end
end