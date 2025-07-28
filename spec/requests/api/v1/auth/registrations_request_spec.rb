require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
    describe "POST /auth" do
        let(:valid_params) { attributes_for(:user) }

        it "ユーザーのレコードが作成できる" do
            expect { post '/api/v1/auth', params: valid_params }.to change { User.count }.by(1)
            res = JSON.parse(response.body)
            expect(response).to have_http_status(:ok)
            expect(res["data"]["id"]).to be_present
            expect(res["data"]["email"]).to eq valid_params[:email]
            expect(response.headers['access-token']).to be_present
            expect(response.headers['client']).to be_present
            expect(response.headers['uid']).to eq(valid_params[:email])
        end
    end
end
