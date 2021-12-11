# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    render json: Movie.all.as_json(except: %i[created_at updated_at])
  end
end
