class Author < ActiveRecord::Base
  has_one :libertarians, dependent: :destroy, class_name: 'Libertarian'
  has_one :newspapers, dependent: :destroy, class_name: 'Newspaper'
  validates_presence_of :name
  validates_uniqueness_of :name
  validate :genre_validation
  attr_reader :genre
  after_create :create_genre
  after_find :initialize_genre
  after_update :update_genre

  Genre = [Libertarian, Newspaper]

  def genre=(value)
    @genre = Genre.map(&:to_s).include?(value) ? value : nil
  end

  def create_genre
    genre.constantize.create! author_id: id
  end

  def initialize_genre
    self.genre = Genre.find { |g| g.where(author_id: id).size > 0 }.to_s
  end

  def update_genre
    old_genre, new_genre = nil, @genre.constantize
    Genre.find { |g| old_genre = g.where(author_id: id)[0] }
    if new_genre != old_genre.class
      new_genre.create!(author_id: id)
      old_genre.destroy!
    end
  end

  private

  def genre_validation
    if !genre
      errors[:genre] << '必須是學者或報社'
    end
  end
end
