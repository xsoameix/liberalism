class Writing < ActiveRecord::Base
  belongs_to :tag
  belongs_to :libertarian
  has_many   :writing_entries, dependent: :destroy
  accepts_nested_attributes_for :writing_entries, allow_destroy: true
  validates_presence_of :begin_date, :end_date, :tag_id, :libertarian_id
  validate :atleast_one_writing_entries
  include ActiveModel::Validations
  validates_with SimpleAssociationValidator
  validates_with DaterangeValidator
  delegate :name, to: :tag,         prefix: true
  delegate :name, to: :libertarian, prefix: true
  before_validation CreateTag.new('著作')
  include Timeline

  def timeline_name; writing_entries.first.title end

  def timeline_body_content
    make_timeline_list
  end

  private

  def atleast_one_writing_entries
    if writing_entries.reject(&:marked_for_destruction?).size < 1
      errors[:writing_entries] << '至少要有一篇/本著作'
    end
  end
end
