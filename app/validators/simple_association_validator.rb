class SimpleAssociationValidator < ActiveModel::Validator
  def validate(record)
    record.class.reflect_on_all_associations.each do |as|
      if !as.klass.exists?(record.read_attribute(as.foreign_key))
        record.errors.add(
          as.foreign_key,
          "此#{record.class.human_attribute_name(as.name)}不存在")
      end
    end
  end
end
