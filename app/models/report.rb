class Report < ActiveRecord::Base
  belongs_to :tag
  belongs_to :newspaper
  belongs_to :libertarian
  validates_presence_of(:title, :begin_date, :end_date,
                        :tag_id, :newspaper_id, :libertarian_id)
  include ActiveModel::Validations
  validates_with SimpleAssociationValidator
  validates_with DaterangeValidator
  validates_with BodyValidator
  delegate :name, to: :tag,         prefix: true
  delegate :name, to: :newspaper,   prefix: true
  delegate :name, to: :libertarian, prefix: true
  before_validation CreateTag.new('報導')
  include Timeline

  def timeline_name; title end

  def timeline_body_content
    (make_timeline_subtitle +
     make_timeline_body +
     make_timeline_stamp)
  end
end
