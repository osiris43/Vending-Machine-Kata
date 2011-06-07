require 'spec_helper'

describe Item do
  describe "has validations" do
    before(:each) do
      @attr = {:description => "Snickers", :price => 0.85, :location => "A1"}
    end

    it "creates a new item" do 
      item = Item.create!(@attr)
      item.should_not be_nil
    end

    it "requires a description" do
      no_desc_item = Item.new(@attr.merge(:description => ""))
      no_desc_item.should_not be_valid 
    end

    it "requires a price" do
      no_price_item = Item.new(@attr.merge(:price => 0.0))
      no_price_item.should_not be_valid
    end

    it "requires a location" do
      no_loc_item = Item.new(@attr.merge(:location => ""))
      no_loc_item.should_not be_valid
    end
    
  end
end
