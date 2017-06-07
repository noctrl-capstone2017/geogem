#Author: Carolyn C
#Purpose: Controller for the Analysis Page
class AnalysisController < ApplicationController
    
    #Finds the name of the student the page belongs to.
    def show
        @student = params[:student_id]
    end 
    
end