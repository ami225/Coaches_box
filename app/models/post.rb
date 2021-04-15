class Post < ApplicationRecord
    has_one_attached :post #一回の投稿で一つ
    belongs_to :coach
end
