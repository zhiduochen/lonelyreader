class ProductsController < ApplicationController
  before_action :authenticate_user!, :only => [:collect, :discollect]
  def index
    if params[:category].blank?
      @products = Product.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(:category_id => @category_id)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @quantity = params[:quantity].to_i
    if current_cart.products.include?(@product)
      flash[:warning] = "你的购物车内已有此物品"
    elsif @quantity <= @product.quantity
      current_cart.add_product_to_cart(@product, @quantity)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "选择的商品数量超过库存"
    end
    redirect_to :back

  end

  def collect
    @product = Product.find(params[:id])
    if !current_user.has_collected?(@product)
      current_user.collect!(@product)
      flash[:notice] = "已加入收藏"
    else
      flash[:warning] = "已在收藏中"

    end
    redirect_to :back

  end

  def discollect
    @product = Product.find(params[:id])
    if current_user.has_collected?(@product)
      current_user.discollect!(@product)
      flash[:notice] = "已移出收藏"
    else
      flash[:warning] = "无此收藏"

    end
    redirect_to :back

  end
end
