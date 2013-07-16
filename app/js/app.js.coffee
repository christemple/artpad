class window.Artpad

  constructor: (page)->
    @page = new Raphael(page, page.width, page.height)
    @$page = $(page)
    @mouse_is_down = false
    @bindEvents()

  bindEvents: ->
    @$page.mousedown (e)=>
      @mouse_is_down = true

      @from =
        x: e.offsetX
        y: e.offsetY
        path: ->
          "M#{@x} #{@y}l0 0"

      @pathString = @from.path()
      @path = @page.path(@pathString);

      @lastX = @from.x
      @lastY = @from.y

    @$page.mouseup =>
      @mouse_is_down = false

    @$page.mousemove (e)=>
      if @mouse_is_down

        @to =
          x: e.offsetX
          y: e.offsetY
          path: (lastX, lastY)->
            'l' + (@x - lastX) + ' ' + (@y - lastY)

        @pathString += @to.path(@lastX, @lastY)
        @path.attr('path', @pathString);

        @lastX = @to.x
        @lastY = @to.y



artpad_page        = document.getElementById 'artpad_page'
artpad_page.height = $('#artpad').height()
artpad_page.width  = $('#artpad').width()

window.artpad = new Artpad(artpad_page)