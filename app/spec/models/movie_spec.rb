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
require 'rails_helper'

RSpec.describe Movie, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
