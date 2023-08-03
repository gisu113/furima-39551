class OrdersController < ApplicationController
  before_action :set_public_key, only: [:index, :create]
  before_action :authenticate_user!, only: :index

  def index
    @item = Item.find(params[:item_id])
    @orderaddress = OrderAddress.new
    if current_user == @item.user
      redirect_to root_path
    end
    if current_user != @item.user && @item.orders.exists?
      redirect_to root_path
    end
  end

  def create
    @orderaddress = OrderAddress.new(order_params)
    if @orderaddress.valid?
      pay_item
      @orderaddress.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :price, :token).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
end
  
  def  pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    @item = Item.find(params[:item_id])
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
    end

    def set_public_key
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    end
  end