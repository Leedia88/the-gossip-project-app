class Tag < ApplicationRecord
    has_many :tags_gossips
    has_many :gossips, through: :tags_gossips
end
