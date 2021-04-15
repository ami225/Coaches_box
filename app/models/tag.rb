class Tag < ApplicationRecord
  has_many   :tag_relationships, dependent: :destroy
  #tag_relationshipsモデルを通してタグに紐づくコーチを取得
  has_many   :coaches, through: :tag_relationships
  #タグの名前が重複するのを防ぐ
  validates :tag_name, uniqueness: true
end
