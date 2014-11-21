require 'rails_helper'

RSpec.describe User, :type => :model do
   it { is_expected.to have_and_belong_to_many(:games) }
end
