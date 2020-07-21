class AuthsController < ApplicationController
  include AuthsHelper
  def new
    redirect_to current_author if logged_in?
  end

  def create
    sign_in
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
