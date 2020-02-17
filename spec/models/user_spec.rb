require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations check' do
    it { should validate_presence_of :name }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(35) }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    subject { FactoryBot.create(:user) }
    it { should validate_presence_of :jti }
  end
end
