require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#owners' do
  let(:acting_owner) { User.create(roles: %w(owner)) }
  subject(:owner_ability) { Ability.new(acting_owner) }

  describe 'on Place' do
    let(:place) { Place.create }

    it { is_expected.to be_able_to(:read, place) }
    it { is_expected.to be_able_to(:create, place) }
    it { is_expected.to be_able_to(:update, place) }
    it { is_expected.to be_able_to(:destroy, place) }
  end
  # on Place
  describe 'on Review' do
    let(:review) { Review.create }

    it { is_expected.to be_able_to(:read, review) }
    it { is_expected.to be_able_to(:create, review) }
    it { is_expected.to be_able_to(:update, review) }
    it { is_expected.to be_able_to(:destroy, review) }
  end
  # on Review
  describe 'on User' do
    let(:user) { User.create }

    it { is_expected.to be_able_to(:read, user) }
    it { is_expected.to be_able_to(:create, user) }
    it { is_expected.to be_able_to(:update, user) }
    it { is_expected.to be_able_to(:destroy, user) }
  end
  # on User
end
