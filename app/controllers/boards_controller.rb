class BoardsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy, :quit, :join]
  before_action :admin_required, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @boards = Board.all

  end

  def show
    @board = Board.find(params[:id])
    @posts = @board.posts.order("created_at DESC")

  end

  def new
    @board = Board.new

  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save
      current_user.join!(@board)
      redirect_to boards_path
    else
      render :new

    end

  end

  def edit
    @board = Board.find(params[:id])

  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to boards_path
    else
      render :edit

    end

  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path

  end

  def join
    @board = Board.find(params[:id])
    if !current_user.is_member_of?(@board)
      current_user.join!(@board)

    end
    redirect_to board_path(@board)

  end

  def quit
    @board = Board.find(params[:id])
    if current_user.is_member_of?(@board)
      current_user.quit!(@board)

    end
    redirect_to board_path(@board)

  end


  private

  def board_params
    params.require(:board).permit(:title, :description)

  end
end
