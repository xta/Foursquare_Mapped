class PagesController < ApplicationController

  def index
    @checkins = Kaminari.paginate_array(current_user.sorted_checkins).page(params[:page]).per(50) if current_user
    @checkins_total = current_user.checkins.size
  end

  def show
    @checkin = Checkin.find(params[:id])
  end

  def load_all_checkins
    FetchJob.new.async.perform(current_user.id, :load_all_checkins!)
    redirect_to root_path
  end

  def sync_checkins
    FetchJob.new.async.perform(current_user.id, :load_any_new_checkins!)
    redirect_to root_path
  end

end
