class LibertariansController < AdminController

  respond_to :html

  def index
    @libertarians = Libertarian.all
  end

  def new
    @libertarian = Libertarian.new
  end

  def edit
    respond_with(@libertarian = Libertarian.find(params[:id]))
  end

  def show
    respond_with(@libertarian = Libertarian.find(params[:id]))
  end

  def create
    @libertarian = Libertarian.new(libertarian_params)
    if @libertarian.save
      flash[:notice] = '已新增一位學者。'
    end
    respond_with(@libertarian)
  end

  def update
    @libertarian = Libertarian.find(params[:id])
    if @libertarian.update_attributes(libertarian_params)
      flash[:notice] = '已更新一位學者。'
    end
    respond_with(@libertarian)
  end

  def destroy
    @libertarian = Libertarian.find(params[:id])
    if @libertarian.destroy
      flash[:notice] = '已刪除一位學者。'
    end
    respond_with(@libertarian)
  end

  private

  def libertarian_params
    params.require(:libertarian).permit *%i(name)
  end
end
