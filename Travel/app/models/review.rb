class Review < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :place
    has_many :likes, dependent: :destroy
    has_many :dislikes, dependent: :destroy
    validates :comments, length: { maximum: 300 },presence: true

end
