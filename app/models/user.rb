class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rooms, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  # userプロフィールバリデーション
  validates :name, presence: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50}
  
  def is_same?(current_user)
    id == current_user.id
  end
end
