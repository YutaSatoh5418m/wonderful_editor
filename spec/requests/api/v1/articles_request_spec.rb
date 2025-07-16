require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /api/articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article, updated_at: 1.days.ago) }
    let!(:article2) { create(:article, updated_at: 2.days.ago) }
    let!(:article3) { create(:article) }

    it "記事の一覧が取得できる" do
      subject
      res = response.parsed_body

      expect(response).to have_http_status(:ok)
      expect(res.length).to eq 3
      expect(res.map {|d| d["id"] }).to eq [article3.id, article1.id, article2.id]
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
    end
  end

  describe "GET /api/articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定した id の記事が存在する場合" do
      let(:article) { create(:article) }
      let(:article_id) { article.id }

      it "任意の記事の値が取得できる" do
        subject
        res = response.parsed_body

        expect(response).to have_http_status(:ok)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present
        expect(res["user"]["id"]).to eq article.user.id
        expect(res["user"].keys).to eq ["id", "name", "email"]
      end
    end

    context "指定した id の記事が存在しない場合" do
      let(:article_id) { 10000 }

      it "記事が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST /api/articles" do
    let(:user) { create(:user) } # FactoryBot等でテスト用ユーザーを用意

    before do
      allow_any_instance_of(Api::V1::BaseApiController).
        to receive(:current_user).
             and_return(user)
    end

    context "有効な属性値で有効であること" do
      it "記事を作成できること" do
        post "/api/articles", params: { article: { title: "タイトル", body: "本文" } }
        expect(response).to have_http_status(:ok)
        # ここで current_user.id が紐づいた記事が作られてるか検証
      end
    end

    context "無効な属性値で有効であること" do
      it "記事が作成できない" do
        expect { subject }.not_to change { Article.count }
      end
    end
  end

  describe "PUT /api/articles/:id" do
    subject { put(api_v1_article_path(article_id), params: { article: { title: "title", body: "body" } }) }

    let(:article) { create(:article) }
    let(:article_id) { article.id }

    context "有効な属性値で有効であること" do
      it "記事が更新できる" do
        expect { subject }.to change { article.title }.to("title")
      end
    end

    context "無効な属性値で有効であること" do
      it "記事が更新できない" do
        expect { subject }.not_to change { article.title }
      end
    end
  end

  describe "DELETE /api/articles/:id" do
    subject { delete(api_v1_article_path(article_id)) }

    let(:article) { create(:article) }
    let(:article_id) { article.id }

    context "有効な属性値で有効であること" do
      it "記事が削除できる" do
        expect { subject }.to change { Article.count }.by(-1)
      end
    end

    context "無効な属性値で有効であること" do
      it "記事が削除できない" do
        expect { subject }.not_to change { Article.count }
      end
    end
  end
end
