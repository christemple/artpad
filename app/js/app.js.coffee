$ ->
  artpad = $('#artpad')
  artpad_page = $('#artpad_page')[0]

  resize_artpad_page = ->
    artpad_page.height = artpad.height()
    artpad_page.width  = artpad.width()

  resize_artpad_page()