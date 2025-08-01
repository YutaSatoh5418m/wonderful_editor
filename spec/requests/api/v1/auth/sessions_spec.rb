require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
    describe "POST /auth/sign_in" do
        let!(:user) { create(:user, email: "test@example.com", password: "password123", password_confirmation: "password123") }
        context "入力された情報が正しいとき" do
            subject { post api_v1_user_session_path, params: valid_params }
            let(:valid_params) do
                {
                  email: user.email,
                  password: user.password
                }
              end
            it "ログインができる" do
                subject
                expect(response.headers["access-token"]).to be_present
                expect(response.headers["client"]).to be_present
                expect(response.headers["uid"]).to eq(user.email)
                expect(response).to have_http_status(:ok)
                json = JSON.parse(response.body)
                expect(json["data"]["email"]).to eq(user.email)
                expect(json["data"]["id"]).to eq(user.id)
            end
        end

        context "入力された情報が正しくないとき" do
            subject { post api_v1_user_session_path, params: invalid_params }
            let(:invalid_params) do
                {
                  email: user.email,
                  password: "wrong_password"
                }
              end
            it "ログインできない" do
                subject
                expect(response).to have_http_status(:unauthorized)
            end
        end
    end

    describe "DELETE /auth/sign_out" do
        let!(:user) { create(:user, email: "test@example.com", password: "password123", password_confirmation: "password123") }
        before do
            post api_v1_user_session_path, params: {
              email: user.email,
              password: "password123"
            }
            @auth_headers = {
              "access-token" => response.headers["access-token"],
              "client" => response.headers["client"],
              "uid" => response.headers["uid"]
            }
        end
        subject { delete destroy_api_v1_user_session_path, headers: @auth_headers }
        fit "ログアウトができる" do
            subject
            expect(response).to have_http_status(:ok)
        end
    end
end
