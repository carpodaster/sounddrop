# We use .map instead of .pluck, as .pluck modifies the SELECT clause and produces strange results.

class Api::DropsController < ApplicationController
  DEFAULT_RADIUS = 10
  respond_to :json

  before_action :notify_for_fixed_radius

  def index
    if params[:latitude] && params[:longitude]
      places_within_radius = Place.near([params[:latitude], params[:longitude]], DEFAULT_RADIUS, units:  :km)
      @drops = Drop.where(place_id: places_within_radius.map(&:id))
    else
      @drops = Drop.all
    end
  end

  private

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
