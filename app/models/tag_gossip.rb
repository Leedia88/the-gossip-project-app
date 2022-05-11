class TagGossip < ApplicationRecord
    belongs_to :tag
  belongs_to :gossip
  validates :tag_id, uniqueness: { scope: :gossip_id }

  def self.find_tags_id(gossip)
    TagGossip.where(gossip: gossip).pluck(:tag_id)
  end

end
