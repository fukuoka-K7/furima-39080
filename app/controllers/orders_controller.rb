class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :non_shippingdestination_item, only: [:index, :create]

  def index
    @order_form = OrderForm.new
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id
  end

  def create
    @order_form = OrderForm.new(order_from_params)
    @item = Item.find(params[:item_id])
    @item.price = Item.find(params[:item_id]).price
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_from_params
    params.require(:order_form).permit(:postal_code, :shipping_from_id, :city, :address1, :address2, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def non_shippingdestination_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
    end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,        # 商品の値段
      card: order_from_params[:token], # カードトークン
      currency: 'jpy'             # 通貨の種類（日本円）
    )
  end
end
