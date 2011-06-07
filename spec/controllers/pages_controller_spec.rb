require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'vending_machine'" do 
    it "is successful" do
      get 'vending_machine'
      response.should be_success
    end

    it "displays the current balance" do
      get 'vending_machine'
      response.should have_selector("em", :content => "$0.00")
    end

    it "tells the user what money it accepts" do
      get 'vending_machine'
      response.should have_selector("span",
                                    :content => "Machine accepts nickels, dimes, quarters and dollars")
    end

    it "has nickel button" do
      get 'vending_machine'
      response.should have_selector("option", :value => "5")
    end

    it "has dime button" do
      get 'vending_machine'
      response.should have_selector("option", :value => "10")
    end

    it "has quarter button" do
      get 'vending_machine'
      response.should have_selector("option", :value => "25")
    end

    it "has dollar button" do
      get 'vending_machine'
      response.should have_selector("option", :value => "100")
    end

    it "has a coin return button" do
      get 'vending_machine'
      response.should have_selector("input", :value => "Coin Return")
    end

    it "has a hidden field for the balance" do
      get 'vending_machine'
      response.should have_selector("input", :type => "hidden", :value => "0")
    end

    it "has link to stock items" do
      get 'vending_machine'
      response.should have_selector("a", :content => "Stock Items")
    end
      
    describe "coin return behaviors" do
      it "returns coins" do
        get 'coin_return', :params => {:currentBalance => 5}
        response.should redirect_to(root_url)
        flash[:notice].should =~ /Coins returned/
      end
    end 

    describe "items display" do
      before(:each) do
        @item = Factory(:item)
        item = Factory(:item)
      end

      it "shows available items" do
        get 'vending_machine'
        response.should have_selector("td", :content => "101")
        response.should have_selector("td", :content => "Snickers")
      end

      it "shows one row with multiple items" do
        get 'vending_machine'
        response.should have_selector("tr", :count => 2)
      end 
    end

    describe "vending items" do
      before(:each) do
        @item = Factory(:item)
        @attr = {:currentBalance => 5, :location => "101"}
      end

      it "has a vend location" do
        get 'vending_machine'
        response.should have_selector("input", :name => "location",
                                     :type => "text")
      end

      it "does not vend if item doesn't exist in location" do
        get 'vend', :currentBalance => "0.05", :location => "A1"
        flash[:notice].should =~ /No item in that location/ 
      end


      it "does not vend if balance is too small" do
        get 'vend', :currentBalance => "0.05", :location => "101"
        flash[:notice].should =~ /Balance is too small/ 
      end

      it "vends item when location and price are correct" do
        get 'vend', :currentBalance => "0.85", :location => "101"
        flash[:notice].should =~ /Enjoy your snack/ 
      end

      it "vends item and provides change for large balances" do
        get 'vend', :currentBalance => "1.00", :location => "101"
        flash[:notice].should =~ /change/
      end

      it "deletes vended item from database" do
        lambda do
          get 'vend', :currentBalance => "0.85", :location => "101"
        end.should change(Item, :count).by(-1)
      end
    end
  end
end
