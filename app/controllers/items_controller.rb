class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def stock
    @item = Item.new(params[:item])
  end

  def create 
    @item = Item.new(params[:item])
    if @item.save
      flash[:notice] = "#{@item.description} successfully added"
      redirect_to items_path
    else
      render :action => :stock
    end
  end

  def index
    @allitems = Item.all
    logger.info "#{@allitems.count} items found."
    @items = Hash.new { |hash, key| hash[key] = []}
    @allitems.each {|e| 
      logger.info "Adding item #{e.description}"
      @items[e.description].push(e)
    }
    logger.info @items
  end
end
