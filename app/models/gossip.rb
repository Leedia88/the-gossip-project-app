class Gossip < ApplicationRecord
    has_many :tags_gossips
    has_many :tags, through: :tags_gossips
    belongs_to :user
    validates :title, presence: true

def self.search(search)
    if search #le champ est rempli
        result = Gossip.where(['content LIKE ? or title LIKE ?', "%#{search}%", "%#{search}%"])
        if result
            @gossips = result
        else
            @gossips = Gossip.all
        end
    else #le champ est vide
        @gossips = Gossip.all
    end
end

end
