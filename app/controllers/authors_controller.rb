class AuthorsController < ApplicationController
  before_action :check_auth, only: [:show]
  before_action :set_author, only: [:show]
  # GET /authors/1
  # GET /authors/1.json
  def show
      if current_author!=set_author
        flash[:notice] = 'You are not allowed to view other authors\' profile.' 
        redirect_to new_auth_path
      end
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # POST /authors
  # POST /authors.json
  def create
    if Author.exists?(name: author_params[:name])
      flash[:alert] =  "This name is taken, please type another one."
      redirect_to new_author_path
      return
    end
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        session[:author_id] = @author.id
        format.html { redirect_to new_auth_path, notice: 'Author account was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { redirect_to new_author_path, alert: 'Please type a valid input paremeter, it should contain at least 2 characters and it should be unique.'  }
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
