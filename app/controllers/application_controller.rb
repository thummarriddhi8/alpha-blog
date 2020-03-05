class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	# To make these two methods available to views
	helper_method :current_user, :logged_in?

	def current_user
		# This technique is called memoization it is performed so that we don't need to hit the database every time
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		# !! is used to turn anything into a boolean
		!!current_user
	end

	def require_user
		if !logged_in?
			flash[:danger] = "You must be logged in to perform that action"
			redirect_to root_path
		end
	end

	def require_same_user
		if current_user != @article.user
			flash[:danger] = "You can only edit or delete your own article."
			redirect_to root_path
		end
	end
end
