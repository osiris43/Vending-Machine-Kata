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
      
    describe "coin return behaviors" do
      before(:each) do
        #test_create_balance(0, 5)
      end

      it "returns coins" do
        get 'coin_return', :params => {:currentBalance => 5}
        response.should redirect_to(root_url)
        flash[:notice].should =~ /Coins returned/
      end
    end 
  end
end
