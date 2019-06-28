class Place < ActiveRecord::Base

    before_create :set_default_average
    has_many :reviews
    belongs_to :user, optional: true
    #attr_accessible :name, :street, :address, :city, :telephone_number, :opening_time, :closing_time, :description, :notices
    validates :name, :presence => true
    validates :street, :presence => true
    validates :address, :presence => true
    validates :city, :presence => true

    private
    
    def set_default_average
        self.average = 0
    end

end
