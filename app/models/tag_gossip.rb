class TagGossip < ApplicationRecord
    belongs_to :tag
  belongs_to :gossip
  validates :tag_id, uniqueness: { scope: :gossip_id }

  def find_tags_id(gossip_id)
    self.where(gossip_id: gossip_id).pluck(:tag_id)
  end
end
