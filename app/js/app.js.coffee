class window.Artpad

  constructor: (page)->
    @page = new Raphael(page, page.width, page.height)
    @$page = $(page)
    @is_mouse_down = false
    @bindEvents()

  bindEvents: ->
    @$page.click ->
      console?.log "In business :)!"


artpad_page        = document.getElementById 'artpad_page'
artpad_page.height = $('#artpad').height()
artpad_page.width  = $('#artpad').width()

window.artpad = new Artpad(artpad_page)