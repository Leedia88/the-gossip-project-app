class TagGossip < ApplicationRecord
    belongs_to :tag
  belongs_to :gossip
  validates :tag_id, uniqueness: { scope: :gossip_id }

  def self.find_tags_id(gossip)
    TagGossip.where(gossip: gossip).pluck(:tag_id)
  end

  def self.find_tags(gossip)
    list = []
    tags_ids = TagGossip.find_tags_id(gossip)
    tags_ids.each do |tag_id|
      list << Tag.find(tag_id)
    end
    list
  end
end
