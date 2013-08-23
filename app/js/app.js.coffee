class window.Artpad

  constructor: (page)->
    @page = new Raphael(page, page.width, page.height)
    @$page = $(page)
    @bindEvents()
    @load_drawing()

  bindEvents: ->
    @$page.mousedown (e)=>
      @trying_to_draw = true
      @from = @get_artists_pencil_location(e)

    @$page.mousemove (e)=>
      @to = @get_artists_pencil_location(e)
      @draw_line() if @trying_to_draw
      @from = @to

    @$page.mouseup =>
      @trying_to_draw = false
      @save_drawing()

    @$page.mouseleave =>
      @trying_to_draw = false

  draw_line: ->
    @page.path("M#{@from.x} #{@from.y}l0 0" + "L#{@to.x} #{@to.y}").attr('stroke-width': 3)

  get_artists_pencil_location: (e)->
    { x: e.offsetX, y: e.offsetY }

  load_drawing: ->
    $.get "#{window.location.pathname}/json", (json)=>
      @page.fromJSON(json)

  save_drawing: ->
    $.post window.location.pathname,
      data: @page.toJSON()


artpad_page        = document.getElementById 'artpad_page'
artpad_page.height = $('#artpad').height()
artpad_page.width  = $('#artpad').width()

new Artpad(artpad_page)