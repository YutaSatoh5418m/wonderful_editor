class Api::V1::ArticlePreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :published_at, :thumbnail_url

  def thumbnail_url
    object.thumbnail&.url
  end
end
