class TimelineController < ApplicationController

  def index
    @begin_date = fetch_default_date('begin_date', Date.new(1900, 1, 1))
    @end_date   = fetch_default_date('end_date',   Date.today)
    respond_to do |format|
      format.html
      format.json { render json: timeline_json }
    end
  end

  def download
    entry = [Report, Article, Event, Writing].map do |klass|
      klass.where(id: params['id'], tag_id: params['tag_id']).first
    end.compact.first
    respond_to do |format|
      format.json do
        render(json:    entry.timeline_json)
      end
      format.html do
        render(html:    entry.timeline_html_content)
      end
      format.docx do
        render(docx:    entry.timeline_docx_name,
               content: entry.timeline_html_content)
      end
    end
  end

  private

  def timeline_json
    text = daterange(@begin_date, @end_date)
    entries = [Report, Article, Event, Writing].flat_map do |klass|
      klass.where(begin_date: @begin_date..@end_date).map(&:timeline_entry)
    end
    timeline = {
      headline: '台灣自由主義學者',
      type: 'default',
      text: text,
      date: entries,
      asset: {
        media: '/assets/flower.jpg'
      }
    }
    {timeline: timeline}
  end

  def fetch_default_date(attribute, default)
    begin
      Date.strptime(params[attribute].to_s, '%Y-%m-%d')
    rescue ArgumentError
      default
    end
  end

  def daterange(begin_date, end_date)
    range = [begin_date, end_date].map { |d| d.strftime '%Y/%m/%d' }.join(' - ')
    ActionController::Base.helpers.content_tag(:h4, "　#{range}")
  end
end
