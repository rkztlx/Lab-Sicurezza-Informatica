class Review < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :place
    validates :comments, length: { maximum: 300 },presence: true

end
