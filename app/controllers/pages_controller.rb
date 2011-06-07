class PagesController < ApplicationController
  attr_accessor :balance
  def vending_machine
    @balance = 0.0
    @items = Item.find(:all, :group => "description")
    @items.each do |item| 
      item.location = "A1"
    end
  end

  def deposit 
    @balance = params[:currentBalance].to_f + params[:amount].to_f / 100 
    respond_to do |format|
      format.html { redirect_to 'vending_machine'}
      format.js
    end
  end

  def coin_return
    flash[:notice] = 'Coins returned'
    redirect_to root_url
  end
end
