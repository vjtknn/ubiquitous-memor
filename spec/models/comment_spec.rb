require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe '#content' do
    it { is_expected.not_to allow_value("").for(:content) }
    it { is_expected.not_to allow_value("ab").for(:content) }
    it { is_expected.not_to allow_value("a" * 251).for(:content) }
  end

  it { is_expected.not_to allow_value("").for(:user_id) }
  it { is_expected.to allow_value(1).for(:user_id) }

  it { is_expected.not_to allow_value("").for(:movie_id) }
  it { is_expected.to allow_value(1).for(:movie_id) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:movie_id) }

end
