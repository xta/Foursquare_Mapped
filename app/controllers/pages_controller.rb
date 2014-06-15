class PagesController < ApplicationController

  def index
  end

  def show
    @checkin = Checkin.find(params[:id])
  end

  def load_all_checkins
    FetchJob.new.async.perform(current_user.id)
    redirect_to root_path
  end

end
