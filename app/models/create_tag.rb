class CreateTag

  def initialize(tagname)
    @tagname = tagname
  end

  def before_validation(model)
    tag = Tag.where(name: @tagname).first
    tag = tag.nil? ? Tag.create(name: @tagname) : tag
    model.tag_id = tag.id
  end
end
