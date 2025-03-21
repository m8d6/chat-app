class DashboardController < ApplicationController
  before_action :require_authentication
  layout "application"

  def index
    @user = current_user
  end
end
