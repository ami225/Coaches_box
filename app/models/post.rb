class Post < ApplicationRecord
  has_one_attached :post # 一回の投稿で一つ
  belongs_to :coach

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 300 }

  # 検索機能looks_forメソッド
  def self.looks_for(searches, words)
    # case文で分岐
    case searches
    when "perfect_match"
      Post.where("title LIKE ?", "#{words}")
    else
      Post.where("title LIKE ?", "%#{words}%")
    end
  end
end
