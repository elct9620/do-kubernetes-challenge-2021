# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id         :bigint           not null, primary key
#  date       :date
#  title      :string
#  title_en   :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :movie do
    title { 'MyString' }
    title_en { 'MyString' }
    date { '2021-12-11' }
    url { 'MyString' }
  end
end
