class FetchJob
  include SuckerPunch::Job

  def perform(user_id, task)
    ActiveRecord::Base.connection_pool.with_connection do
      user = User.find(user_id)
      user.send(task)
    end
  end
end
