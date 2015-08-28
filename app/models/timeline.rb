module Timeline

  def timeline_docx_name
    timeline_name
  end

  def timeline_html_content
    content_tag(:html) do
      content_tag(:body) do
        (content_tag(:h1, make_timeline_title(timeline_name)) +
         timeline_body_content)
      end
    end
  end

  def timeline_json
    except = %w(id created_at updated_at)
    set = [self.class]
    parents = [{self.class => self.class.table_name}]
    expand = {}
    while set.size > 0
      current = set.last
      parent = parents.last
      if parent.keys.all? { |x| x.is_a?(Symbol) }
        set.pop
        parents.pop
        next
      end
      assos = current.reflect_on_all_associations
      includes = assos.select { |as| !expand.has_key?(as.klass) }
      set += includes.map(&:klass)
      include_names = includes.map { |a| [a.klass, a.name] }.to_h
      except_names = assos.select do |as|
        as.is_a?(ActiveRecord::Reflection::BelongsToReflection)
      end.map(&:foreign_key) + except
      node = {include: include_names, except: except_names}
      name = parent[current]
      parent.delete(current)
      parent[name] = node
      parents.push(include_names)
      expand[current] = true
    end
    as_json(parents.last[self.class.table_name])
  end

  def timeline_entry
    make_timeline_entry(
      timeline_name,
      timeline_body_content)
  end

  def make_timeline_entry(title, text)
    text = [
      text,
      content_tag(:p, nil, class: 'clearfix'),
      content_tag(:p, nil, class: 'pull-right') do
        links = [
          content_tag(:a, 'json', href: timeline_download_path(format: :json)),
          content_tag(:a, 'html', href: timeline_download_path(format: :html)),
          content_tag(:a, 'word', href: timeline_download_path(format: :docx))
        ].flat_map.with_index { |l, i| i == 0 ? [l] : ['/', l] }
        (['下載：'] + links).join(?\ ).html_safe
      end,
      content_tag(:div, nil, class: 'clearfix')
    ].join
    {text:      text,
     startDate: html_escape(begin_date.strftime('%Y,%m,%d')),
     endDate:   html_escape(end_date.strftime('%Y,%m,%d')),
     headline:  html_escape(make_timeline_title(title)),
     tag:       html_escape(tag.name)}
  end

  def make_timeline_title(title)
    "#{libertarian.name} - #{title}"
  end

  def make_timeline_subtitle
    content_tag(:h4, subtitle).html_safe
  end

  def make_timeline_body
    unsafe_markdown = body
    safe_html = Markdown.to_html(unsafe_markdown)
    safe_node = Nokogiri::HTML::DocumentFragment.parse(safe_html)
    2.downto(1) do |i|
      safe_node.xpath("./h#{i}").each { |heading| heading.name = "h#{i + 4}" }
    end
    safe_node.xpath('./text()').each(&:unlink)
    safe_node.to_s.html_safe
  end

  def make_timeline_list
    content_tag(:ul) do
      writing_entries.map do |e|
        content_tag(:li) do
          body = [e.title, e.vendor, e.author].reject(&:empty?).join(', ')
          content_tag(:p, body)
        end
      end.join.html_safe
    end
  end

  def make_timeline_stamp
    stamp = "#{newspaper.name} #{begin_date.strftime('%Y-%m-%d')}"
    content_tag(:p, stamp, class: 'timeline-stamp pull-right').html_safe
  end

  def content_tag(*args, &block)
    ActionController::Base.helpers.content_tag(*args, &block)
  end

  def html_escape(arg)
    ERB::Util.html_escape(arg)
  end

  def timeline_download_path(options)
    url_helpers.timeline_download_path(options.merge(id: id, tag_id: tag.id))
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
