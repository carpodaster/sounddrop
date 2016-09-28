class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  def use_your_api_luke
    render json: { errors: "Use your API, Luke!", where_to_go_now: api_drops_url }
  end

end
