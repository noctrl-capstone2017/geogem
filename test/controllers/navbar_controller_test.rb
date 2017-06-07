# Author: Carolyn C
#Purpose: Tests specific pages with the Navbar

require 'test_helper'

class NavbarControllerTest < ActionDispatch::IntegrationTest

    #If on help page, it shoud be navbar1
    test "should get navbar1 for help" do
        get help_path
        assert_response :success
    end
    
    #If on login page, it should be navbar2
    test "should get navbar2" do
        get login_path
        assert_response :success
    end
    
    #If on about1, it should be navbar3  
    test "should get navbar3 for about1" do
        get about_path
        assert_response :success
    end
    
    #If on about2, it should be navbar3
    test "should get navbar3 for about2" do
        get about2_path
        assert_response:success
    end

end