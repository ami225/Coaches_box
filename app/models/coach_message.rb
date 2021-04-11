class CoachMessage < ApplicationRecord
    belongs_to :coach
    has_many :messages
end
