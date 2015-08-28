class Event < ActiveRecord::Base
  belongs_to :tag
  belongs_to :libertarian
  validates_presence_of(:title, :begin_date, :end_date,
                        :tag_id, :libertarian_id)
  include ActiveModel::Validations
  validates_with SimpleAssociationValidator
  validates_with DaterangeValidator
  validates_with BodyValidator
  delegate :name, to: :tag,         prefix: true
  delegate :name, to: :libertarian, prefix: true
  before_validation CreateTag.new('事件')
  include Timeline

  def timeline_name; title end

  def timeline_body_content
    make_timeline_body
  end
end
