class Place < ActiveRecord::Base
    has_many :reviews
    #attr_accessible :name, :street, :address, :city, :telephone_number, :opening_time, :closing_time, :description, :notices
    validates :name, :presence => true
    validates :street, :presence => true
    validates :address, :presence => true
    validates :city, :presence => true
end