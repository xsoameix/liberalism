class Libertarian < ActiveRecord::Base
  belongs_to :author

  class << self

    def title
      '學者'
    end
  end
end
