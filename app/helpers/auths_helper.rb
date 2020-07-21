module AuthsHelper
  def sign_in
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
end
