class EventsController < AdminController

  respond_to :html

  def index
    @libertarians = Libertarian.all
    @q = Event.ransack(params[:q])
    @q.sorts = 'begin_date desc' if @q.sorts.empty?
    @events = @q.result(distict: true).page(params[:page])
  end

  def new
    @event = Event.new
    @libertarians = Libertarian.all
  end

  def edit
    @event = Event.find(params[:id])
    @libertarians = Libertarian.all
    respond_with(@event)
  end

  def show
    respond_with(@event = Event.find(params[:id]))
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = '已新增一篇事件。'
    else
      @libertarians = Libertarian.all
    end
    respond_with(@event)
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = '已更新一篇事件。'
    else
      @libertarians = Libertarian.all
    end
    respond_with(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:notice] = '已刪除一篇事件。'
    end
    respond_with(@event)
  end

  private

  def event_params
    params.require(:event).permit *%i(title
      begin_date end_date body libertarian_id)
  end
end
