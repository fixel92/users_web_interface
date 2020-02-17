require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }

  describe '#show' do
    context 'auth' do
      before(:each) { sign_in user1 }
      it 'returns success' do
        get :show, params: { id: user2.id }

        expect(response.status).to eq 200
      end
    end

    context 'anonym' do
      it 'returns not_success' do
        get :show, params: { id: user2.id }

        expect(response.status).not_to eq 200
      end
    end
  end

  describe '#update' do
    context 'auth' do
      before(:each) { sign_in user1 }
      it 'returns success' do
        expect(user1.name).not_to eq 'test'

        put :update, params: { id: user1.id, user: { name: 'test' } }

        json_response = JSON.parse(response.body)
        user1.reload

        expect(user1.name).to eq 'test'
        expect(response.status).to eq 200
        expect(json_response.keys).to eq(%w[data])
      end

      it 'returns 403' do
        expect(user2.name).not_to eq 'test'
        put :update, params: { id: user2.id, user: { name: 'test' } }

        json_response = JSON.parse(response.body)

        user2.reload

        expect(user2.name).not_to eq 'test'
        expect(json_response['status']).to eq 403
        expect(json_response['error']).to eq 'Forbidden'
      end
    end

    context 'anonym' do
      it 'returns 403' do
        expect(user2.name).not_to eq 'test'

        put :update, params: { id: user2.id, user: { name: 'test' } }

        user2.reload

        expect(user2.name).not_to eq 'test'
        expect(response.status).to eq 403
        expect(response.body).to eq "{'error' : 'Forbidden'}"
      end
    end
  end
end
