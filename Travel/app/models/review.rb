class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :place
    attr_protected :user_id
    validates :comments, length: { maximum: 300 },presence: true
    # review is valid only if it’s associated with a place:
    validates :place_id, :presence => true
    # require that the referenced place itself be valid
    #  in order for the review to be valid:
    validates_associated :place
end
