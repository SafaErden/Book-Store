class AuthsController < ApplicationController
 
  # GET /auths/new
  def new
    if logged_in?
      redirect_to current_author
    end
  end

  # POST /auths
  # POST /auths.json
  def create
    @author = Author.find_by(name: params[:name])
    new_auth_path
    if @author
      session[:author_id] = @author.id
      redirect_to  @author
    else
      respond_to do |format|
        format.html { redirect_to new_auth_path, notice: 'Invalid Name' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /auths/1
  # DELETE /auths/1.json
  def destroy
    session[:author_id]=nil
    respond_to do |format|
      format.html { redirect_to new_auth_path, notice: 'Auth was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def auth_params
      params.require(:auth).permit(:name)
    end
end
