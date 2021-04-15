class TagRelationship < ApplicationRecord
  belongs_to :coach
  belongs_to :tag
end
