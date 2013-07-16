class window.Artpad

  constructor: (page)->
    @page = new Raphael(page, page.width, page.height)
    @$page = $(page)
    @mouse_is_down = false
    @bindEvents()

  bindEvents: ->
    @$page.mousedown (e)=>
      @mouse_is_down = true

      x = e.offsetX
      y = e.offsetY
      @pathString = 'M' + x + ' ' + y + 'l0 0';
      @path = @page.path(@pathString);

      @lastX = x
      @lastY = y

    @$page.mouseup =>
      @mouse_is_down = false

    @$page.mousemove (e)=>
      if @mouse_is_down
        x = e.offsetX
        y = e.offsetY
        @pathString += 'l' + (x - @lastX) + ' ' + (y - @lastY);
        @path.attr('path', @pathString);

        @lastX = x
        @lastY = y



artpad_page        = document.getElementById 'artpad_page'
artpad_page.height = $('#artpad').height()
artpad_page.width  = $('#artpad').width()

window.artpad = new Artpad(artpad_page)