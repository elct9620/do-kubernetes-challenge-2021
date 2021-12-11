# frozen_string_literal: true

require 'vscinemas'

namespace :movie do
  desc 'refresh movies'
  task refresh: :environment do
    movies = VSCinemas
             .movies
             .map(&:to_h)
             .map do |movie|
      movie
        .transform_keys(detail_url: :url)
        .slice(:id, :title, :title_en, :date, :url)
        .tap { |item| item[:url] = item[:url].to_s }
    end

    Movie.import movies, on_duplicate_key_update: [:id]
    puts "Refresh #{movies.size} movies"
  end
end
