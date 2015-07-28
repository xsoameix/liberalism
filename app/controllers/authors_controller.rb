class AuthorsController < ApplicationController
  before_action :authenticate_user!

  respond_to :html

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def edit
    respond_with(@author = Author.find(params[:id]))
  end

  def show
    respond_with(@author = Author.find(params[:id]))
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      flash[:notice] = '已新增一位作者。'
    end
    respond_with(@author)
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(author_params)
      flash[:notice] = '已更新一位作者。'
    end
    respond_with(@author)
  end

  def destroy
    @author = Author.find(params[:id])
    if @author.destroy
      flash[:notice] = '已刪除一位作者。'
    end
    respond_with(@author)
  end

  private

  def author_params
    params.require(:author).permit *%i(name genre)
  end
end
