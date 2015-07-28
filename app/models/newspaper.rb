class Newspaper < ActiveRecord::Base
  belongs_to :author

  class << self

    def title
      '報社'
    end
  end
end
