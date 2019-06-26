module UsersHelper
  
  # Returns the Gravatar for the given user.
  def gravatar_for(user)
      if user.avatar_url == nil || user.avatar_url == ""
          gravatar_url = "#{root_url}assets/pic.png"
      else
          gravatar_url = user.avatar_url
      end
      image_tag(gravatar_url, alt: user.avatar_url, class: "gravatar")
  end
  
end
