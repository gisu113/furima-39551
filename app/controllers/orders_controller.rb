class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @orderaddress = OrderAddress.new
  end

  def new
    @item = Item.find(params[:item_id])
    @order = Order.new
  end

  def create
    @orderaddress = OrderAddress.new(order_params)
    if @orderaddress.valid?
      @orderaddress.save(params,current_user.id)
       redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end
      
    private
    def order_params
      params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
    end
  end