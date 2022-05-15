class Tag < ApplicationRecord
    has_many :tags_gossips
    has_many :gossips, through: :tags_gossips

def self.get_id(name)
    tag = Tag.where('title LIKE ?', "%#{name}%")
    if tag.exists?
        tag.first.id
    else
        color = "#" + "%06x" % (rand * 0xffffff)
        tag = Tag.create(title: "#".concat(name), color: color)
        tag.id
    end
end

def self.get_list(gossip)
    list = TagGossip.find_tags_id(gossip)
    list.map!{ |id| Tag.find(id).title[1..-1]}
    list.join(" ")
end


end