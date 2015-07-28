class Article < ActiveRecord::Base
  belongs_to :provider, class_name: 'Author'
  belongs_to :origin, class_name: 'Author'
  belongs_to :tag
  validates_presence_of(:title, :provider_id, :origin_id,
                        :begin_date, :end_date, :tag_id)
  include ActiveModel::Validations
  validates_with ::SimpleAssociationValidator
  validate :date_validation
  validate :body_validation
  delegate :name, to: :provider, prefix: true
  delegate :name, to: :origin,   prefix: true
  delegate :name, to: :tag,      prefix: true

  Sanitizer = Class.new(ActionView::Base).new

  private

  def date_validation
    if begin_date && end_date && begin_date >= end_date
      errors[:begin_date] << '結束日期必須在開始日期之後，至少後一天'
    end
  end

  def body_validation
    unsafe_markdown = body.encode(body.encoding, universal_newline: true)
    unsafe_html = Markdown.to_html(unsafe_markdown)
    unsafe_normalized_markdown = ReverseMarkdown.convert(unsafe_html)
    safe_html = Sanitizer.sanitize(unsafe_html)
    safe_normalized_markdown = ReverseMarkdown.convert(safe_html)
    if unsafe_normalized_markdown != safe_normalized_markdown
      errors[:body] << '內文有非法字元'
    end
  end
end
