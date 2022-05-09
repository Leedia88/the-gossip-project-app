class Gossip < ApplicationRecord
    has_many :tags_gossips
    has_many :tags, through: :tags_gossips
    belongs_to :user
    validates :title, presence: true
end
