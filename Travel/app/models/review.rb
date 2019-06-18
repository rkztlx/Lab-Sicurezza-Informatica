class Review < ActiveRecord::Base
    belongs_to :user
    validates :description, length: { maximum: 300 },presence: true
end
