class Coach < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many  :tag_relationships, dependent: :destroy
  # tag_relationshipsモデルを通してコーチに紐づいているtagを取得
  has_many  :tags, through: :tag_relationships
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  def save_tags(savecoach_tags)
    # 既存のタグを取得
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    # 消すタグを取得
    old_tags = current_tags - savecoach_tags
    # 新しいタグを取得
    new_tags = savecoach_tags - current_tags

    old_tags.each do |old_tag_name|
      tags.delete Tag.find_by(tag_name: old_tag_name)
    end
    new_tags.each do |new_tag_name|
      # タグを探してなければ
      coach_tag = Tag.find_or_create_by(tag_name: new_tag_name)
      tags << coach_tag
    end
  end

  # お気に入りメソッド
  def favorited_by?(user)
    # 引数で渡されたユーザidがFavoritesテーブル内に存在していればtrue存在していなければfalse
    favorites.where(user_id: user.id).exists?
  end

  # 検索機能メソッド
  def self.looks_for(search, words)
    case search
    when "perfect_match"
      Coach.where("name LIKE ?", "#{words}")
    else
      Coach.where("name LIKE ?", "%#{words}%")
    end
  end

  # ログインしているコーチかどうか
  # % if @coach.id == current_coach.id % この文をメソッド化
  def is_same?(current_coach)
    # idはcoachモデルに書いているので勝手にcoach_idと変換してくれる
    id == current_coach.id
  end

  # コーチバリデーション
  validates :name, uniqueness: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
