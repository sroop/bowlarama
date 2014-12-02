class Game < ActiveRecord::Base
  has_many :scoresheets
  has_many :users, through: :scoresheets
end
