class Gossip < ApplicationRecord
    has_many :comments, as: :commentable
    has_many :tags_gossips
    has_many :tags, through: :tags_gossips
    has_many :likes
    belongs_to :user
    validates :title, presence: true
    validates :content, presence: true

def self.search(search)
    if search #le champ est rempli
        result = Gossip.where(['lower(content) LIKE ? or lower(title) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"])
        if result
            @gossips = result
        else
            @gossips = Gossip.all
        end
    else #le champ est vide
        @gossips = Gossip.all
    end
end

def self.search_by_city(city_name)
    list=[]
    city = City.find_by(name: city_name)
    puts city
    if city #la recherche aboutit
        users = User.where(city: city)
        puts users
        users.each do |user|
             list.concat(Gossip.where(user: user))
        end
        list
    else #le champ est vide
        @gossips = Gossip.all
    end
end

def self.get_gossip_list(users)
    list = []
    users.each do |user|
        list.concat(Gossip.where(user: user))
    end
    list
end

def count_likes
    Like.where(gossip_id: self.id).count
end

def is_liked?(user)
    Like.find_by(user: user, gossip_id: self.id)!= nil
end

def get_like(user)
    Like.find_by(user: user, gossip_id: self.id)
end

end
