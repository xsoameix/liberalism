class NewspapersController < AdminController

  respond_to :html

  def index
    @newspapers = Newspaper.all
  end

  def new
    @newspaper = Newspaper.new
  end

  def edit
    respond_with(@newspaper = Newspaper.find(params[:id]))
  end

  def show
    respond_with(@newspaper = Newspaper.find(params[:id]))
  end

  def create
    @newspaper = Newspaper.new(newspaper_params)
    if @newspaper.save
      flash[:notice] = '已新增一位報社。'
    end
    respond_with(@newspaper)
  end

  def update
    @newspaper = Newspaper.find(params[:id])
    if @newspaper.update_attributes(newspaper_params)
      flash[:notice] = '已更新一位報社。'
    end
    respond_with(@newspaper)
  end

  def destroy
    @newspaper = Newspaper.find(params[:id])
    if @newspaper.destroy
      flash[:notice] = '已刪除一位報社。'
    end
    respond_with(@newspaper)
  end

  private

  def newspaper_params
    params.require(:newspaper).permit *%i(name)
  end
end
