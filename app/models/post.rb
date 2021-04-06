class Post < ApplicationRecord
    has_one_attached :post #一回の投稿で一つ
    has_many :favorites, dependent: :destroy
    belongs_to :user, optional: true
    has_many :post_category_relations
    has_many :categories, through: :post_category_relations

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
