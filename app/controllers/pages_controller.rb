class PagesController < ApplicationController
  attr_accessor :balance
  def vending_machine
    @balance = 0.0
    @items = Item.find(:all, :group => "location")
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

  def vend
    @balance = params[:currentBalance].to_f 
    logger.info params[:location]
    item = Item.find_by_location(params[:location])

    if !item
      flash[:notice] = "No item in that location"
    else
      if @balance < item.price
        flash[:notice] = "Balance is too small"
      elsif @balance == item.price
        flash[:notice] = "Enjoy your snack"
      else
        flash[:notice] = "Enjoy your snack. Don't forget your change."
      end
    end
  end
end
