require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
    describe "POST /auth" do
        let(:valid_params) { attributes_for(:user) }

        it "ユーザーのレコードが作成できる" do
            post '/api/v1/auth', params: valid_params
            binding.pry
            # res = JSON.parse(response.body)
        end
    end
end
