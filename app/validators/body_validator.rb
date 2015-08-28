class BodyValidator < ActiveModel::Validator

  Sanitizer = Class.new(ActionView::Base).new

  def validate(record)
    body = record.body
    unsafe_markdown = body.encode(body.encoding, universal_newline: true)
    unsafe_html = Markdown.to_html(unsafe_markdown)
    unsafe_normalized_markdown = ReverseMarkdown.convert(unsafe_html)
    safe_html = Sanitizer.sanitize(unsafe_html)
    safe_normalized_markdown = ReverseMarkdown.convert(safe_html)
    if unsafe_normalized_markdown != safe_normalized_markdown
      record.errors[:body] << '內文有非法字元'
    end
  end
end
