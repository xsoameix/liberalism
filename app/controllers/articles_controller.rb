class ArticlesController < AdminController

  respond_to :html

  def index
    @newspapers = Newspaper.all
    @libertarians = Libertarian.all
    @q = Article.ransack(params[:q])
    @q.sorts = 'begin_date desc' if @q.sorts.empty?
    @articles = @q.result(distict: true).page(params[:page])
  end

  def new
    @article = Article.new
    @newspapers = Newspaper.all
    @libertarians = Libertarian.all
  end

  def edit
    @article = Article.find(params[:id])
    @newspapers = Newspaper.all
    @libertarians = Libertarian.all
    respond_with(@article)
  end

  def show
    respond_with(@article = Article.find(params[:id]))
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = '已新增一篇專欄。'
    else
      @newspapers = Newspaper.all
      @libertarians = Libertarian.all
    end
    respond_with(@article)
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = '已更新一篇專欄。'
    else
      @newspapers = Newspaper.all
      @libertarians = Libertarian.all
    end
    respond_with(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = '已刪除一篇專欄。'
    end
    respond_with(@article)
  end

  private

  def article_params
    params.require(:article).permit *%i(title subtitle
      begin_date end_date body newspaper_id libertarian_id)
  end
end
