# == Schema Information
# Schema version: 20110603181853
#
# Table name: items
#
#  id          :integer         not null, primary key
#  price       :float
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Item < ActiveRecord::Base
  attr_accessor :location
  attr_accessible :price, :description, :location

  validates(:description, :presence => true)
  validates_numericality_of(:price, :greater_than => 0.0)
end
