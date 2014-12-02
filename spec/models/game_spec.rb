require 'rails_helper'

RSpec.describe Game, :type => :model do
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:scoresheets) }
end
