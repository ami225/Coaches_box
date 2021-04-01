class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :coach
end
