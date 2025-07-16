module Api::V1
  # base_api_controller を継承
  class ArticlesController < BaseApiController
    def index
      articles = Article.order(updated_at: :desc)
      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end

    def show
      article = Article.find(params[:id])
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def create
      article = Article.new(article_params)
      if article.save
        render json: article, serializer: Api::V1::ArticleSerializer
      else
        render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      article = Article.find(params[:id])
      if article.update(article_params)
        render json: article, serializer: Api::V1::ArticleSerializer
      else
        render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      article = Article.find(params[:id])
      article.destroy!
      render json: { message: "Article deleted successfully" }, status: :ok
    end

    private

      def article_params
        params.require(:article).permit(:title, :content)
      end
  end
end
