class TagGossip < ApplicationRecord
    belongs_to :tag
  belongs_to :gossip
  validates :tag_id, uniqueness: { scope: :gossip_id }
end
