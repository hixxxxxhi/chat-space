require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  describe 'GET #show' do
    context 'when logged in' do
      before do
        login_user user
      end

      it "assigns the requested group to @group" do
        get :show, params: { group_id: group.id }
        expect(assigns(:group)).to eq group
      end

      it "renders the :show template" do
        get :show, params: { group_id: group.id }
        expect(response).to render_template :show
      end

      after do
        sign_out :user
      end
    end

    context 'when NOT logged in' do
      it "redirects to the /users/sign_in page" do
        get :show, params: { group_id: group.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    before do
        login_user user
    end

    context 'when logged in and saved successfully' do
      it "saves the new message in the database" do
        expect{
          post :create, params: { group_id: group, message: attributes_for(:message) }
        }.to change(Message, :count).by(1)
      end

      it "redirects to group_messages_path(:group_id)" do
        post :create, params: { group_id: group, message: attributes_for(:message) }
        expect(response).to redirect_to(group_messages_path(group))
      end
    end

    context 'when logged in and NOT saved successfully' do
      it "does NOT save the new message in the database" do
        post :create, params: { group_id: group, message: attributes_for(:message, body: nil, image: nil) }
        expect(flash[:alert]).to match("メッセージを入力してください。")
      end

      it "redirects to group_messages_path(:group_id)" do
        post :create, params: { group_id: group, message: attributes_for(:message, body: nil, image: nil) }
        expect(response).to redirect_to(group_messages_path(group))
      end
    end

    after do
        sign_out :user
    end
  end
end
