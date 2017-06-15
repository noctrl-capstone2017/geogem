# Authors: Meagan Moore & Steven Royster
class StaticPagesController < ApplicationController
  # these are special pages that handle their own navbar and layout 
  before_action :special_navbar_and_layout

  # skip login guard; these pages don't require login
  skip_before_action :require_login

  def about1
  end

  def about2
  end

  def help
  end

end
