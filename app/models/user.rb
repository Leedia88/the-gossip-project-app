class User < ApplicationRecord
    has_many :gossips, dependent: :destroy
    belongs_to :city
    has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
    has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"

    def self.full_name_list
        list =[]
        User.all.each do |user|
            list << [(user.first_name + " "+user.last_name), user.id]
        end
        list
    end

    def full_name
        (self.first_name + " "+self.last_name)
    end

end