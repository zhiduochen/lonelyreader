class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy

    flash[:warning] = "成功将 #{@product.title} 从购物车删除！"
    redirect_to :back
  end

  def add
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.quantity < @cart_item.product.quantity
      @cart_item.quantity += 1
      @cart_item.save
      redirect_to carts_path
    elsif @cart_item.quantity == @cart_item.product.quantity
      redirect_to :back, alert: "库存不足"

    end

  end

  def minus
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.quantity > 1
      @cart_item.quantity -= 1
      @cart_item.save
      redirect_to carts_path
    elsif @cart_item.quantity == 1
      redirect_to :back, alert: "数量至少一个"

    end

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

end
