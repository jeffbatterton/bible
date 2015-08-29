class ReaderController < ApplicationController

  def index
    @books          = Book.all
  end

  def book
    @book_number    = params[:book_number]
    @book_title     = params[:book_title]
    render "book", layout: false
  end

  def chapter
    @book_number    = params[:book_number]
    @chapter_number = params[:chapter_number]
    @chapter_text   = params[:chapter_text]
    render "chapter", layout: false
  end

end
