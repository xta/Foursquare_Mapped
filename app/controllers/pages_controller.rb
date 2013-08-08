class PagesController < ApplicationController

	def index
	end

	def show
		@checkin = Checkin.find(params[:id])
	end

	def load_all_checkins
		current_user.load_all_checkins!
		redirect_to root_path
	end

end