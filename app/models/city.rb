class City < ApplicationRecord
    has_many :users
    has_many :comments, as: :commentable
    validates :name, presence: true

def self.name_list
    list =[]
        City.all.each do |citi|
            list << [citi.name , citi.id]
        end
    list
end

end
