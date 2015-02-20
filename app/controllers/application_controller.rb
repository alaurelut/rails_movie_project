class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  require 'themoviedb'

  before_filter :set_config
  Tmdb::Api.key("8a221fc31fcdf12a8af827465574ffc9")

  def set_config
    @configuration = Tmdb::Configuration.new
  end


end