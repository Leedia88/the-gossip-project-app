class PrivateMessage < ApplicationRecord

    belongs_to :sender, class_name: "User"
    has_many :recipients, class_name: "User"
    validates :content, presence: true
    
    validate :recipient_is_not_sender

    def recipient_is_not_sender
        if :sender == :recipient
            errors.add(:recipient, "The recipient cannot be the sender")
        end
    end
    s
end
