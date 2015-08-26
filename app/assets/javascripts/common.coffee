@App ||= {}

# Setup datepicker
class App.Datepicker
  constructor: ->
    @rangepicker = $('.input-daterange').datepicker({
      language: 'zh-TW', container: '.input-daterange', oritation: 'top left'}
    )
    update = ->
      $(this).children('input[type="text"]').each ->
        (self = $(this)).next('input[type="hidden"]').val(
          moment(self.val(), 'YYYY-MM-DD').format('YYYY-MM-DD'))
    @updateEvents = [update]
    @rangepicker.on 'changeDate', =>
      @updateEvents.forEach (e) =>
        e.call(@rangepicker)
    .children('input[type="text"]').map (i) ->
      self = $(this)
      parsed = moment(self.next('input[type="hidden"]').val(), 'YYYY-MM-DD')
      [[self, (if parsed.isValid() then parsed else moment().add(i, 'days'))]]
    .each ->
      @[0].datepicker('setDate', @[1].toDate())

  addUpdateEvent: (e) ->
    @updateEvents.push(e)

$(document).on 'page:change', ->
  # Setup moment
  moment.locale('zh-tw')

  # Setup data-confirm
  dataConfirmModal.setDefaults(
    {title: '請再確認一次', commit: '確定', cancel: '取消'})

  # Fadeout the alert
  setTimeout ->
    $('.alert').fadeTo(500, 0).slideUp 500, ->
      $(this).remove()
  , 2000

  # Active the checked radiobox
  $('input[checked="checked"]').parent('.btn').addClass('active')

  # activate selectize.js plugin
  App.GlobalSelect = $('select').selectize(sortField: 'text')

  App.GlobalDatepicker = new App.Datepicker
