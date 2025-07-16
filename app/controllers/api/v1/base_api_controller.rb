class Api::V1::BaseApiController < ApplicationController
  def current_user
    # 通常は Devise Token Auth が提供する current_user があるが、
    # テスト中だけここが使われるようにする
    User.first # 仮に users テーブルの先頭のユーザーを返す
  end
end
