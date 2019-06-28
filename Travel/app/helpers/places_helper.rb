module PlacesHelper
  
  # Returns the Gravatar for the given place.
  def icon_for(place)
      
    if place.icon == nil || place.icon == ""
        icon = "#{root_url}assets/place.png"
      else
        icon = place.icon
      end
      image_tag(icon, alt: place.icon, class: "gravatar",  size: "180x180")
  end
  
end
