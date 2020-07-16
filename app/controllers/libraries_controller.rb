class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :edit, :update, :destroy]
  before_action :check_auth
  # GET /libraries
  # GET /libraries.json
  def index
    @libraries = current_author.libraries.order("name ASC")
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
   if current_author.libraries.include?set_library
    @libray=set_library
    @books=set_library.books
    @book_author=true
   else
    flash[:notice] = 'You are not allowed to view other authors libraries.' 
    redirect_to libraries_url
   end
  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # POST /libraries
  # POST /libraries.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      begin
        @library = Library.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @library=nil
      end
      
    end

    # Only allow a list of trusted parameters through.
    def library_params
      params.require(:library).permit(:name, :image)
    end
end
