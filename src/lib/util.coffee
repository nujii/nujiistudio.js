
module.exports =

  pxToSec: (px, scale)->
    px/scale

  secToPx: (sec, scale)->
    sec*scale

  # This function is kind of a hack (but a cool one)
  # to find the width of the browser's scrollbar
  scrollBarWidth: ()->
    wNoScroll = 0
    wScroll = 0

    # Outer scrolling div
    scr = document.createElement 'div'
    scr.style.position = 'absolute'
    scr.style.top = '-1000px'
    scr.style.left = '-1000px'
    scr.style.width = '100px'
    scr.style.height = '50px'
    # Start with no scrollbar
    scr.style.overflow = 'hidden'

    # Inner content div
    inn = document.createElement('div')
    inn.style.width = '100%'
    inn.style.height = '200px'

    # Put the inner div in the scrolling div
    scr.appendChild inn
    # Append the scrolling div to the doc
    document.body.appendChild scr

    # Width of the inner div sans scrollbar
    wNoScroll = inn.offsetWidth
    # Add the scrollbar
    scr.style.overflow = 'auto'
    # Width of the inner div width scrollbar
    wScroll = inn.offsetWidth

    # Remove the scrolling div from the doc
    document.body.removeChild document.body.lastChild

    # Pixel width of the scroller
    (wNoScroll - wScroll)

  guidGenerator: ->
    S4 = ->
      (((1 + Math.random()) * 0x10000) | 0).toString(16).substring 1

    S4() + S4() + "-" + S4() + "-" + S4() +
    "-" + S4() + "-" + S4() + S4() + S4()