# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :title_en
      t.date :date
      t.string :url

      t.timestamps
    end
  end
end
