class WritingEntry < ActiveRecord::Base
  belongs_to :writing
  validates_presence_of :title
end
