class AuthsController < ApplicationController
  def new
    redirect_to current_author if logged_in?
  end

  def create
    if params[:name].size < 2
      flash[:alert] = 'Please type a valid name, it should contain at least 2 characters.'
      redirect_to new_auth_path
      return
    end
    @author = Author.find_by(name: params[:name])

    if @author
      session[:author_id] = @author.id
      redirect_to @author
    else
      respond_to do |format|
        alert_text = 'Sorry, we have no author with this input. Please sign up, if you don\'t have an account.'
        format.html { redirect_to new_auth_path, alert: alert_text }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    session[:author_id] = nil
    respond_to do |format|
      format.html { redirect_to new_auth_path, notice: 'Successfully logged out.' }
      format.json { head :no_content }
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:name)
  end
end
