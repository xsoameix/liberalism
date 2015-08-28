class Markdown

  Context = V8::Context.new.tap do |c|
    c.eval('window = {}')
    c.load(Rails.root + 'vendor/assets/javascripts/markdown.js')
  end

  class << self

    def to_html(string)
      Context.eval("window.markdown.toHTML(#{string.inspect})")
    end
  end
end
