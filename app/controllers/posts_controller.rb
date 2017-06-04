class PostsController < ApplicationController
  before_action :authenticate_user!, :except => :show
  before_action :check_permission, :except => :show

  def new
    @board = Board.find(params[:board_id])
    @post = Post.new

  end

  def create
    @board = Board.find(params[:board_id])
    @post = Post.new(post_params)
    @post.board = @board
    @post.user = current_user
    if @post.save
      redirect_to board_path(@board)
    else
      render :new

    end

  end

  def edit
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])

  end

  def update
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to board_path(@board)

    end

  end

  def show
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.all

  end

  def destroy
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to board_path(@board)

  end

  private

  def post_params
    params.require(:post).permit(:title, :content)

  end

  def check_permission
    @board = Board.find(params[:board_id])
    if !current_user.is_member_of?(@board)
      redirect_to board_path(@board), alert: "无权限，请先加入该讨论版"

    end

  end
end
