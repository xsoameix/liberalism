class WritingsController < AdminController

  respond_to :html

  def index
    @libertarians = Libertarian.all
    @q = Writing.ransack(params[:q])
    @q.sorts = 'begin_date desc' if @q.sorts.empty?
    @writings = @q.result(distict: true).page(params[:page])
  end

  def new
    @writing = Writing.new
    @libertarians = Libertarian.all
  end

  def edit
    @writing = Writing.find(params[:id])
    @libertarians = Libertarian.all
    respond_with(@writing)
  end

  def show
    respond_with(@writing = Writing.find(params[:id]))
  end

  def create
    @writing = Writing.new(writing_params)
    if @writing.save
      flash[:notice] = '已新增一篇著作。'
    else
      @libertarians = Libertarian.all
    end
    respond_with(@writing)
  end

  def update
    @writing = Writing.find(params[:id])
    if @writing.update_attributes(writing_params)
      flash[:notice] = '已更新一篇著作。'
    else
      @libertarians = Libertarian.all
    end
    respond_with(@writing)
  end

  def destroy
    @writing = Writing.find(params[:id])
    if @writing.destroy
      flash[:notice] = '已刪除一篇著作。'
    end
    respond_with(@writing)
  end

  private

  def writing_params
    params.require(:writing).permit *(
      %i(begin_date end_date libertarian_id).push(
        writing_entries_attributes: %i(id title vendor author _destroy)))
  end
end
