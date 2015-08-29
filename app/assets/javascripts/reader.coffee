# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document)

  # book menu
  .on "click", "#books a", (e) ->
    targetBook = $(this).data "book-number"
    # set book number
    $("body").attr("data-book-number", targetBook).attr "data-active-section", "chapters"
    # set book title
    $("#book-title-container").load "/book/#{targetBook}?book_title=true"
    # play sound (!!!)
    playSound "swipe"
    # load chapter menu
    $("#chapter-container").load "/book/#{targetBook}"
    # empty verse menu
    $("#verse-container").empty()
    e.preventDefault()

  # chapter menu
  .on "click", "#chapter-container a", (e) ->
    return false if $(this).hasClass "active"
    targetChapter = $(this).data "chapter-number"
    targetBook    = $("body").data "book-number"
    # set active class
    $("#chapter-container .active").removeClass "active"
    $(this).addClass "active"
    # play sound (!!!)
    playSound "click"
    # set chapter number
    $("#chapter-number-container").html targetChapter
    # load verse menu
    $("#verse-container").load "/book/#{targetBook}/chapter/#{targetChapter}"
    # load entire chapter text
    $("#reader").load "/book/#{targetBook}/chapter/#{targetChapter}?chapter_text=true"
    e.preventDefault()

  # verse menu
  .on "click", "#verse-container a", (e) ->
    # change page
    $("body").attr "data-active-section", "reader"
    # play sound (!!!)
    playSound "swipe"
    # scroll to verse
    #################
    e.preventDefault()

  # back button
  .on "click", "header a", (e) ->
    targetSection = "books"
    targetSection = "chapters" if $("body").attr("data-active-section") is "reader"
    # change page
    $("body").attr "data-active-section", targetSection
    # play sound (!!!)
    playSound "swipe"
    e.preventDefault()

# play sound
playSound = (sound) ->
  $("#sound-#{sound}").get(0).play()
