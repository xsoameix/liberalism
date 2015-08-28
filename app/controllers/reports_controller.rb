class ReportsController < AdminController

  respond_to :html

  def index
    @newspapers = Newspaper.all
    @libertarians = Libertarian.all
    @q = Report.ransack(params[:q])
    @q.sorts = 'begin_date desc' if @q.sorts.empty?
    @reports = @q.result(distict: true).page(params[:page])
  end

  def new
    @report = Report.new
    @newspapers = Newspaper.all
    @libertarians = Libertarian.all
  end

  def edit
    @report = Report.find(params[:id])
    @newspapers = Newspaper.all
    @libertarians = Libertarian.all
    respond_with(@report)
  end

  def show
    respond_with(@report = Report.find(params[:id]))
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      flash[:notice] = '已新增一篇報導。'
    else
      @newspapers = Newspaper.all
      @libertarians = Libertarian.all
    end
    respond_with(@report)
  end

  def update
    @report = Report.find(params[:id])
    if @report.update_attributes(report_params)
      flash[:notice] = '已更新一篇報導。'
    else
      @newspapers = Newspaper.all
      @libertarians = Libertarian.all
    end
    respond_with(@report)
  end

  def destroy
    @report = Report.find(params[:id])
    if @report.destroy
      flash[:notice] = '已刪除一篇報導。'
    end
    respond_with(@report)
  end

  private

  def report_params
    params.require(:report).permit *%i(title subtitle
      begin_date end_date body newspaper_id libertarian_id)
  end
end
