class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new

  end

  def create
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      redirect_to board_post_path(@board, @post)
    else
      render :new

    end

  end

  def destroy
    @board = Board.find(params[:board_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to board_post_path(@board, @post)

  end

  private

  def comment_params
    params.require(:comment).permit(:content)

  end
end
