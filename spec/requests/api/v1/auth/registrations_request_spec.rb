require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
    describe "POST /auth" do
        subject { post api_v1_user_registration_path, params: params }

        context "正常系" do
            let(:params) { attributes_for(:user) }

            fit "ユーザーのレコードが作成できる" do
                expect { subject }.to change { User.count }.by(1)
                res = JSON.parse(response.body)
                expect(response).to have_http_status(:ok)
                expect(res["data"]["id"]).to be_present
                expect(res["data"]["email"]).to eq params[:email]
                expect(response.headers['access-token']).to be_present
                expect(response.headers['client']).to be_present
                expect(response.headers['uid']).to eq(params[:email])
            end
        end

        context "異常系" do
            let(:params) { attributes_for(:user, email: "invalid_email") }

            it "ユーザーのレコードが作成できない" do
                subject
                binding.pry
            end
        end
    end
end
