# Static Pages Controller
# Author: Meagan Moore & Steven Royster
  
  class StaticPagesController < ApplicationController
    # Skips guard require login because these pages don't require login
    skip_before_action :require_login
        
    def about1
    end
    
    def about2
    end
    
    def help
    end
    
  end