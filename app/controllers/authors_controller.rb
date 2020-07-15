class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
      if current_author!=set_author
        flash[:notice] = 'You are not allowed to view other Authors profile.' 
        redirect_to current_author
      end
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to new_auth_path, notice: 'Author account was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { redirect_to new_author_path, notice: 'Please type a valid input paremeter, it should contain at least 2 characters and it should be unique.'  }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      begin
        @author = Author.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @author=nil
      end
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name)
    end
end
