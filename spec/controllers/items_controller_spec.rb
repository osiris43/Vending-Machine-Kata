require 'spec_helper'

describe ItemsController do
  render_views

  describe "GET 'index'" do
    before(:each) do
      @item = Factory(:item)
      @item2 = Factory(:item)
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have 1 line with 2 items" do
      get :index
      response.should have_selector("li", :content => "2 Snickers")
    end

  end

  describe "GET 'stock'" do
    it "is successful" do
      get :stock 
      response.should be_success
    end

    it "has a description field" do
      get :stock
      response.should have_selector("input[name='item[description]'][type='text']")
    end

    it "has a price field" do
      get :stock
      response.should have_selector("input[name='item[price]'][type='text']")
    end

    it "has a location field" do
      get :stock
      response.should have_selector("input[name='item[location]'][type='text']")
    end

  end

  describe "POST 'create'" do
    before(:each) do
      @attr = { :description => "Snicker's", :price => 0.85, :location => "A1"}
    end
    
    describe "success" do
      it "creates item" do
        lambda do
          post :create, :item => @attr
        end.should change(Item, :count).by(1)
      end
    end
  end
end
