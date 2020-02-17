require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, admin: true) }
  let(:user_params) do
    {
      user: {
        name: 'test',
        email: 'test@example.com',
        password: '123123'
      }
    }
  end

  %w[index show edit new].each do |action|
    describe "##{action}" do
      context 'auth' do
        before(:each) { sign_in user }

        it 'kick from #sign_in' do
          get :"#{action}", params: { id: user.id }

          expect(response.status).not_to eq 200
          expect(response).to redirect_to(new_user_session_path)
          expect(flash[:alert]).to be
        end
      end

      context 'admin' do
        before(:each) { sign_in admin }

        it "#{action} User success" do
          get :"#{action}", params: { id: admin.id }

          expect(response.status).to eq 200
          expect(response).to render_template("#{action}")
        end
      end

      context 'anonym' do
        it 'kick from #sign_in' do
          get :"#{action}", params: { id: user.id }

          expect(response.status).not_to eq 200
          expect(response).to redirect_to(new_user_session_path)
          expect(flash[:alert]).to be
        end
      end
    end
  end

  describe '#create' do
    context 'auth' do
      before(:each) { sign_in user }

      it 'kick from #sign_in' do
        post :create, params: user_params

        expect {
          post :create, params: user_params
        }.to change(User, :count).by(0)

        expect(response.status).not_to eq 200
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to be
      end
    end

    context 'admin' do
      before(:each) { sign_in admin }

      it '#create User success' do
        expect {
          post :create, params: user_params
        }.to change(User, :count).by(+1)

        user = assigns(:user)

        expect(user.valid?).to eq true
        expect(user.persisted?).to eq true
        expect(response.status).to eq 302
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be
      end

      it '#create User failed' do
        expect {
          post :create, params: {
            user: {
              name: '',
              email: 'test@example.com',
              password: '123123'
            }
          }
        }.to change(User, :count).by(0)

        user = assigns(:user)

        expect(user.valid?).to eq false
        expect(user.persisted?).to eq false
      end
    end

    context 'anonym' do
      it 'kick from #sign_in' do
        post :create, params: user_params

        expect {
          post :create, params: user_params
        }.to change(User, :count).by(0)

        expect(response.status).not_to eq 200
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to be
      end
    end
  end

  describe '#update' do
    let(:user_for_update) { FactoryBot.create(:user) }
    before(:each) { user_params[:id] = user_for_update.id }

    context 'auth' do
      before(:each) { sign_in user }

      it 'kick from #sign_in' do
        post :update, params: user_params

        expect(response.status).not_to eq 200
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to be
      end
    end

    context 'admin' do
      before(:each) { sign_in admin }

      it '#update User success' do
        expect(user_for_update.name).not_to eq 'test'
        expect(user_for_update.email).not_to eq 'test@example.com'

        put :update, params: user_params

        user_for_update.reload

        user = assigns(:user)

        expect(user.valid?).to eq true
        expect(user_for_update.name).to eq 'test'
        expect(user_for_update.email).to eq 'test@example.com'
        expect(response.status).to eq 302
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be
      end

      it '#update User failed' do
        expect(user_for_update.name).not_to eq 'test'
        expect(user_for_update.email).not_to eq 'test@example.com'

        put :update, params: {
          id: user_for_update.id,
          user: {
            name: '',
            email: 'test@example.com'
          }
        }

        user_for_update.reload
        user = assigns(:user)

        expect(user.valid?).to eq false
        expect(user_for_update.name).not_to eq ''
        expect(user_for_update.email).not_to eq 'test@example.com'
      end
    end

    context 'anonym' do
      it 'kick from #sign_in' do
        put :update, params: user_params

        expect(response.status).not_to eq 200
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to be
      end
    end
  end

  describe '#delete' do
    let!(:user_for_delete) { FactoryBot.create(:user) }
    before(:each) { user_params[:id] = user_for_delete.id }

    context 'auth' do
      before(:each) { sign_in user }

      it 'kick from #sign_in' do
        expect {
          delete :destroy, params: user_params
        }.to change(User, :count).by(0)

        expect(response.status).not_to eq 200
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to be
      end
    end

    context 'admin' do
      before(:each) { sign_in admin }

      it '#destroy User success' do
        expect(user.persisted?).to eq true

        expect { delete :destroy, params: { id: user.id } }.to change(User, :count).by(-1)

        expect(response.status).to eq 302
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be
      end
    end

    context 'anonym' do
      it 'kick from #sign_in' do
        expect {
          delete :destroy, params: user_params
        }.to change(User, :count).by(0)

        expect(response.status).not_to eq 200
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to be
      end
    end
  end
end
