class window.Artpad

  constructor: (page)->
    @page = new Raphael(page, page.width, page.height)
    @$page = $(page)
    @bindEvents()

  bindEvents: ->
    @$page.mousedown (e)=>
      @trying_to_draw = true
      @from = @get_artists_pencil_location(e)

    @$page.mousemove (e)=>
      @to = @get_artists_pencil_location(e)
      @draw_line() if @trying_to_draw

    @$page.mouseup =>
      @trying_to_draw = false

    @$page.mouseleave =>
      @trying_to_draw = false


  draw_line: ->
    path = @page.path("M#{@from.x} #{@from.y}l0 0" + "L#{@to.x} #{@to.y}")
    path.attr('stroke-width': 3)
    @from.x = @to.x
    @from.y = @to.y

  get_artists_pencil_location: (e)->
    { x: e.offsetX, y: e.offsetY }



artpad_page        = document.getElementById 'artpad_page'
artpad_page.height = $('#artpad').height()
artpad_page.width  = $('#artpad').width()

new Artpad(artpad_page)