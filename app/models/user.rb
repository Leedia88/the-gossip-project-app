class User < ApplicationRecord
    has_many :gossips, dependent: :destroy
    belongs_to :city
    has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
    has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
    has_many :comments, as: :commentable
    validates :password, presence: true, length: { minimum: 6 }
    validates :age, numericality: { only_integer: true }
    validates :email, 
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }

    has_secure_password

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

    def remember(remember_token)
        remember_digest = BCrypt::Password.create(remember_token)
        self.update(remember_digest: remember_digest)
    end
    

end
