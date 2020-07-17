# rubocop:disable Style/GuardClause
class AuthorsController < ApplicationController
  before_action :check_auth, only: [:show]
  before_action :set_author, only: [:show]

  def show
    if current_author != set_author
      flash[:notice] = 'You are not allowed to view other authors\' profile.'
      redirect_to new_auth_path
    end
  end

  def new
    @author = Author.new
  end

  def create
    if Author.exists?(name: author_params[:name])
      flash[:alert] = 'This name is taken, please type another one.'
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
        alert_text = 'Type a valid input paremeter, it should contain at least 2 characters and it should be unique.'
        format.html { redirect_to new_author_path, alert: alert_text }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  rescue StandardError
    @author = nil
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
# rubocop:enable Style/GuardClause
