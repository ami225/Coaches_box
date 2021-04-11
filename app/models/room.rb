class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :coach_entries, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :user_entries, dependent: :destroy
end
