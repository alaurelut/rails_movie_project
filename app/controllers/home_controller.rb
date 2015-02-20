class HomeController < ApplicationController

  def index
    @now_playing = Tmdb::Movie.now_playing

    @now_playing.first(10).each { |item| 

      if Movie.where("movie_id = ?", item.id).size == 0

          trailers =  Tmdb::Movie.trailers(item.id)
          details = Tmdb::Movie.detail(item.id)

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

        create = Movie.create(movie_id: item.id ,title: item.title, release_date: item.release_date, poster: item.poster_path, genre: genres, description: details.overview, trailer: trailer)

      end
    }

    @movies = Movie.all.order(release_date: :desc).first(10)

  end

end
