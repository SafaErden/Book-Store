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
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        session[:author_id] = @author.id
        format.html { redirect_to new_auth_path, notice: 'Author account was successfully created.' }
      else
        format.html { redirect_to new_author_path, alert: @author.errors.full_messages.first }
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
