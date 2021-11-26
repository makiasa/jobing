class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required
  add_flash_types :success, :info, :warning, :danger
  
  private
  def login_required
    redirect_to login_path unless current_user
  end
end
