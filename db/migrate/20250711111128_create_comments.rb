class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.bigint :user_id
      t.bigint :article_id

      t.timestamps
    end
  end
end
