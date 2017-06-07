#Author: Ricky Perez

require 'test_helper'

class RosterSquaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roster_square = roster_squares(:one)
  end
  #Makes a new roster_square
  test "should create roster_square" do
    assert_difference('RosterSquare.count') do
     roster_square = RosterSquare.create(:student_id => 1, :square_id => 1)
    end
  end

  #Goes to the first roster squares link
  test "should get edit student 1" do
    get "/roster_squares/1/edit"
    assert_response :found
  end

  #test "should get error at student last + 1" do
   # get "/roster_squares/#{@students.last}/edit"
  #end
end
