module DropsHelper
  def show_place_location(place)
    if place.longitude && place.latitude
      "Coordinates : #{place.latitude} / #{place.longitude}"
    end
  end
end