$(document).on 'page:change', ->
  # generate preview of each components
  $("[data-behavior=bind][data-to]").each ->
    name = $(preview = this).data('to')
    input = $("[data-behavior=bind][data-name=#{name}]")[0]
    update = -> preview.innerHTML = input.value
    input.oninput = update
    update()

  # generate stamp under the body
  $("[data-behavior=bind-stamp][data-to]").each ->
    name = $(preview = this).data('to')
    begin_date = $("[data-behavior=bind-stamp-date][data-name=#{name}]")[0]
    origin     = $("[data-behavior=bind-stamp][data-name=#{name}]").next().find('input')[0]
    update = ->
      preview.innerHTML = markdown.toHTML(
        [$(origin).prev().text()
         moment(begin_date.value, 'YYYY-MM-DD').format('l')].join(' '))
    App.GlobalSelect.on('change', update)
    App.GlobalDatepicker.addUpdateEvent(update)
    update()

  # activate codemirror
  editors = {}
  $("[data-behavior=bind-body][data-to]").each ->
    name = $(preview = this).data('to')
    text = $("[data-behavior=bind-body][data-name=#{name}]")[0]
    editors[name] = editor = CodeMirror.fromTextArea(text, {
      mode: 'markdown', lineWrapping: true, theme: "default",
      extraKeys: {'Enter': 'newlineAndIndentContinueMarkdownList'}
    })
    editor.on 'focus', ->
      $(text).next().addClass('CodeMirror-focus')
    editor.on 'blur', ->
      $(text).next().removeClass('CodeMirror-focus')
    update = -> preview.innerHTML = markdown.toHTML(editor.getValue())
    editor.on 'change', update
    update()

  # when user click navbar button, refresh the textarea
  $("[data-toggle=tab][data-refresh]").on 'click', ->
    name = $(this).data('refresh')
    setTimeout (-> editors[name].refresh()), 200

  # when user click example button, fill up textarea with body example
  $("[data-behavior=bind-example]").on 'click', ->
    name = $(text = this).data('to')
    editor = editors[name]
    editor.setValue($(text).children('.hidden').text())
    editor.refresh()

  # generate example preview of the tutorial
  $("[data-behavior=bind-preview][data-to]").each ->
    name = $(preview = this).data('to')
    input = $("[data-behavior=bind-preview][data-name=#{name}]")
    preview.innerHTML = markdown.toHTML(input.text())
