class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  layout "unauthenticated"

  def new
    @user = User.new
  end

  def create
  end
end
