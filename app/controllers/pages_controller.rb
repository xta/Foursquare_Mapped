class PagesController < ApplicationController

  def index
    @checkins = Kaminari.paginate_array(current_user.sorted_checkins).page(params[:page]).per(50) if current_user
  end

  def show
    @checkin = Checkin.find(params[:id])
  end

  def load_all_checkins
    FetchJob.new.async.perform(current_user.id)
    redirect_to root_path
  end

end
