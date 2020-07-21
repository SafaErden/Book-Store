class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :check_auth

  def index
    @books = current_author.books.desc
    @image = true
  end

  def store
    @books = Book.all.desc.includes(:author).where("author_id!=?", current_author.id)
    @image = false
  end

  def new
    @book = Book.new
    @libraries = current_author.libraries
    @message = if @libraries.size.zero?
                 'If you want to choose a category for your book, you should create a category before publishing it.'
               else
                 'Choose a category for you book.'
               end
  end

  def create
    @book = current_author.books.build(book_params)
    @library = Library.find_by(id: library_params[:library_id])

    @book.libraries << @library unless @library.nil?
    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'Book was successfully created.' }
      else
        format.html { redirect_to new_book_path, alert: @book.errors.full_messages.first }
      end
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :amount)
  end

  def library_params
    params.require(:book).permit(:library_id)
  end
end
