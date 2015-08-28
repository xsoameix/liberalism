class SimpleAssociationValidator < ActiveModel::Validator
  def validate(record)
    record.class.reflect_on_all_associations.select do |as|
      as.is_a?(ActiveRecord::Reflection::BelongsToReflection) &&
      !as.klass.exists?(record.read_attribute(as.foreign_key))
    end.each do |as|
      name = record.class.human_attribute_name(as.name)
      record.errors.add(as.foreign_key, "此#{name}不存在")
    end
  end
end
