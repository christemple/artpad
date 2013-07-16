class window.Artpad

  constructor: (page)->
    @page = new Raphael(page, page.width, page.height)
    @$page = $(page)
    @trying_to_draw = false
    @bindEvents()

  bindEvents: ->
    @$page.mousedown (e)=>
      @trying_to_draw = true
      @from =
        x: e.offsetX
        y: e.offsetY
        path_string: ->
          "M#{@x} #{@y}l0 0"

    @$page.mouseup =>
      @trying_to_draw = false

    @$page.mousemove (e)=>
      @to =
        x: e.offsetX
        y: e.offsetY
        path_string: (from_x, from_y)->
          'l' + (@x - from_x) + ' ' + (@y - from_y)

      @draw_line() if @trying_to_draw

  draw_line: ->
    @page.path(@from.path_string() + @to.path_string(@from.x, @from.y))
    @from.x = @to.x
    @from.y = @to.y



artpad_page        = document.getElementById 'artpad_page'
artpad_page.height = $('#artpad').height()
artpad_page.width  = $('#artpad').width()

window.artpad = new Artpad(artpad_page)