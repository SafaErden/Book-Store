# rubocop:disable Style/GuardClause
class ApplicationController < ActionController::Base
  helper_method :current_author
  helper_method :logged_in?

  def current_author
    Author.find_by(id: session[:author_id])
  end

  def logged_in?
    !current_author.nil?
  end

  def check_auth
    unless logged_in?
      flash[:alert] = 'Please sign in to access this page.'
      redirect_to new_auth_path
    end
  end
end
# rubocop:enable Style/GuardClause
