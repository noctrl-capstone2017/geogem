# Author: Robert Herrera
require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  # Use the fixtures to set the testing env's school. Teacher is set to super user.
  setup do
    @school = schools(:one)
    log_in_as(teachers(:one))
  end
  
  # This test makes sure super_url gets the super dashboard page
  test "should get super dashboard" do
    get super_url
    assert_response :success
  end
 # This test makes sure schools_url gets the school page
  test "should get schools index" do
    get schools_url
    assert_response :success
  end
  # This test makes sure backup_url gets the backup school page
  test "should get backup school page" do
    get school_backup_url
    assert_response :success
  end 
  # This test makes sure restore_url gets the restore school page 
  test "should get restore school page" do
    get school_restore_url
    assert_response :success
  end 
  # This test makes sure suspend_url gets the suspend school page 
  test "should get suspend school page" do
    get school_suspend_url
    assert_response :success
  end 
end #end of super_test.rb file