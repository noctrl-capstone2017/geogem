require 'test_helper'

  # authors: Ricky Perez & Michael Loptien
  # Tests for Student Controller

class SquaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(teachers(:one))   #Log in a teacher
    @square = squares(:one)     #Set a square
  end

# Show show index page, requires an Adim to be signed in
  test "should get index" do
    get squares_url
    assert_response :success
  end

# Should pull up new square view
  test "should get new" do
    get new_square_url
    assert_response :success
  end

# Should create a square
  test "should create square" do
    assert_difference('Square.count') do
      post squares_url, params: { square: { color: "red",
      school_id: "1",
      description: "Desc", 
      screen_name: "CT", tracking_type: 1} }
    end
    assert_redirected_to squares_url
  end

# Should not create a square - missing description
  test "should not create square. Empty Desc" do
    assert_no_difference('Square.count') do
      post squares_url, params: { square: { color: "red",
      school_id: "1",
      description: "", 
      screen_name: "CT",
      tracking_type: 1} }
    end
  end

# Should pull up edit view of a square
  test "should get edit" do
    get edit_square_url(@square)
    assert_response :success
  end

# Should update a squares values
  test "should update square" do
    patch square_url(@square), params: { square: { color: "red",
    school_id: "1",
    description: "Desc",
    screen_name: "CT",
    tracking_type: 1} }
    assert_redirected_to squares_url
  end

end
