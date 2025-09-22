class ApplicationController < ActionController::Base
  before_action :load_nav_lists

  private
  def load_nav_lists
    @nav_lists = List.all   # o current_user.lists si tenés auth
  end
end
