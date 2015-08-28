$(document).ready ->
  source = $('#timeline-source')
  begin_date = source.data('begin-date')
  end_date   = source.data('end-date')
  url = "/?begin_date=#{begin_date}&end_date=#{end_date}"
  $.ajax({
    url: url,
    dataType: 'json',
    success: (data) ->
      createStoryJS({
        type:     'timeline',
        width:    '100%',
        height:   '670',
        source:   data,
        embed_id: 'timeline-embed',
        lang:     'zh-tw'
      })
  })
