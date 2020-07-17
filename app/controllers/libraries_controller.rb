class LibrariesController < ApplicationController
  before_action :set_library, only: %i[show edit update destroy]
  before_action :check_auth

  def index
    @libraries = current_author.libraries.order('name ASC')
  end

  def show
    if current_author.libraries.include? set_library
      @libray = set_library
      @books = set_library.books
      @book_author = true
    else
      flash[:notice] = 'You are not allowed to view other authors libraries.'
      redirect_to libraries_url
    end
  end

  def new
    @library = Library.new
  end

  def create
    @library = current_author.libraries.build(library_params)
    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_library
    @library = Library.find(params[:id])
  rescue StandardError
    @library = nil
  end

  def library_params
    params.require(:library).permit(:name, :image)
  end
end
