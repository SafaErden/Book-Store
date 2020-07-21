class AuthsController < ApplicationController
  def new
    redirect_to current_author if logged_in?
  end

  def create
    @author = Author.find_by(name: params[:name])

    if @author
      session[:author_id] = @author.id
      redirect_to @author
    else
      respond_to do |format|
        alert_text = 'Sorry, we have no author with this input. Please sign up, if you don\'t have an account.'
        format.html { redirect_to new_auth_path, alert: alert_text }
      end
    end
  end

  def destroy
    session[:author_id] = nil
    respond_to do |format|
      format.html { redirect_to new_auth_path, notice: 'Successfully logged out.' }
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:name)
  end
end
