module ApplicationHelper
	def gravatar_for(user, options = { size: 80 })
		# generate an MD5 hash
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		# put its value to get the gravatar_url
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.username, class: 'img-circle')
	end
end
