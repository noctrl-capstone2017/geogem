# Author: Carolyn C
# Tests specific pages with the Navbar
require 'test_helper'

class NavbarControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:one)
  end

  # 1) goto home page and look for the standard navbar
  test 'standard navbar' do
    log_in_as(@teacher)
    get home_path
    assert_select 'a[href="/home"]'   # logo/left of navbar
    assert_select 'a[href="/help"]'   # right half of navbar
    assert_select 'a[href="/super"]'
    assert_select 'a[href="/admin"]'
    assert_select 'a[href="/profile"]'
    assert_select 'a[href="/logout"]'
  end

  # 2) goto help and about pages when NOT logged in - stripped down navbar
  test 'check navbar when NOT logged in' do
    get help_path
    assert_select 'a[href="/home"]', false
    assert_select 'a[href="/help"]', false
    assert_select 'a[href="/super"]', false
    assert_select 'a[href="/admin"]', false
    assert_select 'a[href="/profile"]', false
    assert_select 'a[href="/logout"]', false
    assert_select 'a[href="/login"]'
    
    get about_path
    assert_select 'a[href="/home"]', false
    assert_select 'a[href="/help"]', false
    assert_select 'a[href="/super"]', false
    assert_select 'a[href="/admin"]', false
    assert_select 'a[href="/profile"]', false
    assert_select 'a[href="/logout"]', false
    assert_select 'a[href="/login"]'

    get about_student_art_path
    assert_select 'a[href="/home"]', false
    assert_select 'a[href="/help"]', false
    assert_select 'a[href="/super"]', false
    assert_select 'a[href="/admin"]', false
    assert_select 'a[href="/profile"]', false
    assert_select 'a[href="/logout"]', false
    assert_select 'a[href="/login"]'
  end

  # 3) check root page (login) navbar - only about page link
  test 'check login navbar' do
    get root_path
    assert_select 'a[href="/home"]', false
    assert_select 'a[href="/help"]', false
    assert_select 'a[href="/super"]', false
    assert_select 'a[href="/admin"]', false
    assert_select 'a[href="/profile"]', false
    assert_select 'a[href="/logout"]', false
    assert_select 'a[href="/about"]'
  end

  # 4) check logout page navbar - only back to login link
  test 'check logout navbar' do
    get logout_path
    assert_select 'a[href="/home"]', false
    assert_select 'a[href="/help"]', false
    assert_select 'a[href="/super"]', false
    assert_select 'a[href="/admin"]', false
    assert_select 'a[href="/profile"]', false
    assert_select 'a[href="/logout"]', false
    assert_select 'a[href="/login"]'
  end

end
