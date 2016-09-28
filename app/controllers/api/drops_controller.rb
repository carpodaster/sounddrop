# We use .map instead of .pluck, as .pluck modifies the SELECT clause and produces strange results.

class Api::DropsController < ApplicationController
  DEFAULT_RADIUS = 10
  respond_to :json

  before_action :notify_for_fixed_radius
  before_action :require_lat_lng

  def index
    @drops = Drop.near([params[:latitude], params[:longitude]], DEFAULT_RADIUS, units: :km)
  end

  private

  def require_lat_lng
    unless params[:latitude] && params[:longitude]
      render json: { errors: ["Both latitude and longitude provided you have not."] }
    end
  end

  def notify_for_fixed_radius
    if params[:radius]
      render json: {
        accepted_radius: 10,
        queried_radius: params[:radius],
        comments: {
          yoda: "Not allowed it is in this version of sounddrop. Fixed the radius is. In your cleverness we trust, young padawans. Always pass on what you have learned."
        }
      }
    end
  end

end
