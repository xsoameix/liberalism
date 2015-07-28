class ArticlesController < ApplicationController
  before_action :authenticate_user!

  respond_to :html

  def index
    @providers, @origins = Author::Genre.map { |g| g.includes(:author) }
    @q = Article.ransack(params[:q])
    @q.sorts = 'begin_date desc' if @q.sorts.empty?
    @articles = @q.result(distict: true).page(params[:page])
  end

  def new
    @article = Article.new
    @providers, @origins = Author::Genre.map { |g| g.includes(:author) }
    @tags = Tag.all
  end

  def edit
    @article = Article.find(params[:id])
    @providers, @origins = Author::Genre.map { |g| g.includes(:author) }
    @tags = Tag.all
    respond_with(@article)
  end

  def show
    respond_with(@article = Article.find(params[:id]))
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = '已新增一篇文章'
    else
      @providers, @origins = Author::Genre.map { |g| g.includes(:author) }
      @tags = Tag.all
    end
    respond_with(@article)
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = '已更新一篇文章。'
    else
      @providers, @origins = Author::Genre.map { |g| g.includes(:author) }
      @tags = Tag.all
    end
    respond_with(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = '已刪除一篇文章。'
    end
    respond_with(@article)
  end

  private

  def article_params
    params.require(:article).permit *%i(
      title subtitle provider_id origin_id begin_date end_date body tag_id)
  end
end
