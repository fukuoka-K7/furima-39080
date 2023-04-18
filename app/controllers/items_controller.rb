class ItemsController < ApplicationController
 before_action :authenticate_user! 

  def index 
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path(@item)
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :description, :category_id, :condition_id, :shipping_burden_id, :shipping_from_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
  
end

