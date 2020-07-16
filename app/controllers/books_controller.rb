class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = current_author.books
  end  
  
  def store
    @books = Book.all.select{|book| book.author != current_author}
  end


  # GET /books/new
  def new
    @book = Book.new
    @libraries=current_author.libraries
    if @libraries.size.zero?
      @message="Before publishing a new book, you should create a category."
    else
      @message="Choose a category for you book."
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = current_author.books.build(book_params)
    @library=Library.find_by(id: library_params[:library_id])

    if book_params[:name].nil? || book_params[:name].size < 3
      flash[:alert] = 'Please type a valid book name that contains at least 2 characters..' 
      redirect_to new_book_path
      return
    end

    if book_params[:amount].nil? || book_params[:amount].to_i < 1
      flash[:alert] = 'Please type a valid price value higher than 0.' 
      redirect_to new_book_path
      return
    end
    
    if @library.nil?
      flash[:alert] = 'You should choose a valid category that belongs to you to publish a new book.' 
      redirect_to new_book_path
      return
    else
      @book.libraries << @library
    end
    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else 
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :amount)
    end
    def library_params
      params.require(:book).permit(:library_id)
    end
end
