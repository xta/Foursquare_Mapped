class PagesController < ApplicationController

	def index
	end

	def load_all_checkins
		current_user.load_all_checkins!
		redirect_to root_path
	end

end