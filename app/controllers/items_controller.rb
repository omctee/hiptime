class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = current_user.items.build
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "Info: Item was updated!"
    else
      render 'edit'
    end

  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description)
  end

  def find_item
    @item = Item.find(params[:id])
  end


end
