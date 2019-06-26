module UsersHelper
  
  # Returns the Gravatar for the given user.
  def gravatar_for(user)
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      if user.avatar_url == nil
          gravatar_url = "#{root_url}assets/pic.png"
      else
          gravatar_url = user.avatar_url
      end
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
end
