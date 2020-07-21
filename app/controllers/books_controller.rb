# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :check_auth

  def index
    @books = current_author.books.order('created_at DESC')
    @image = true
  end

  def store
    @books = Book.all.order('created_at DESC').reject { |book| book.author == current_author }
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

    if book_params[:name].nil? || book_params[:name].size < 2
      flash[:alert] = 'Please type a valid book name that contains at least 2 characters..'
      redirect_to new_book_path
      return
    end

    if book_params[:amount].nil? || book_params[:amount].to_i < 1
      flash[:alert] = 'Please type a valid price value higher than 0.'
      redirect_to new_book_path
      return
    end

    unless @library.nil?
      @book.libraries << @library
    end
    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'Book was successfully created.' }
      else
        format.html { render :new }
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
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
