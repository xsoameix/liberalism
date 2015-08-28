class DaterangeValidator < ActiveModel::Validator
  def validate(record)
    if (record.begin_date && record.end_date &&
        record.begin_date >= record.end_date)
      record.errors[:begin_date] << '結束日期必須在開始日期之後，至少後一天'
    end
  end
end
