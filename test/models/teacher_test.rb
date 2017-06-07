# author: Kevin M, Tommy B
# Teacher model testing.

require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  setup do
    #Using setup here instead of fixtures because fixtures cause errors.
    @teacher = Teacher.new(user_name: "profbill",
                password: "password",
                password_confirmation: "password",
                last_login: Time.now,
                full_name: "Professor Bill",
                screen_name: "profbill",
                icon: "apple",
                color: "red",
                email: "wtktriger@noctrl.edu",
                description: "Super user",
                powers: "Admin",
                school_id: 1)
  end
  
  # Tests the teacher against the validations from the model file
  test "should be valid" do
    assert @teacher.valid?
  end
  
  # Tests what happens when we remove the user_name
  test "user_name should be present" do
    @teacher.user_name = ""
    assert_not @teacher.valid?
  end
  
  # Tests what happens when we remove the full_name
  test "full_name should be present" do
    @teacher.full_name = ""
    assert_not @teacher.valid?
  end
  
  # Remove screen_name and test
  test "screen_name should be present" do
    @teacher.screen_name = ""
    assert_not @teacher.valid?
  end
  
  # Remove icon and test
  test "icon should be present" do
    @teacher.icon = ""
    assert_not @teacher.valid?
  end
  
  # Remove color and test
  test "color should be present" do
    @teacher.color = ""
    assert_not @teacher.valid?
  end
  
  # Remove email and test
  test "email should be present" do
    @teacher.email = ""
    assert_not @teacher.valid?
  end
  
  # Remove description and test
  test "description shouldn't be required" do
    @teacher.description = ""
    assert @teacher.valid?
  end
  
  # Remove powers and test
  test "powers should be present" do
    @teacher.powers = ""
    assert_not @teacher.valid?
  end
  
  # Remove school_id and test
  test "school_id should be present" do
    @teacher.school_id = ""
    assert_not @teacher.valid?
  end
  
  # Test length of user_name
  test "user_name should not be too long" do
    @teacher.user_name = "a" * 76
    assert_not @teacher.valid?
  end
  
  # Test length of full_name
  test "full_name should not be too long" do
    @teacher.full_name = "a" * 76
    assert_not @teacher.valid?
  end
  
  # Test length of screen_name
  test "screen_name should not be too long" do
    @teacher.screen_name = "a" * 76
    assert_not @teacher.valid?
  end
  
  # Test that every screen_name is unique
  test "screen_name should be unique" do
    duplicate_user = @teacher.dup
    duplicate_user.screen_name = @teacher.screen_name.upcase
    @teacher.save
    assert_not duplicate_user.valid?
  end
  
  # Test length of email
  test "email should not be too long" do
    @teacher.email = "a" * 256
    assert_not @teacher.valid?
  end
  
  # Test for valid email address
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @teacher.email = valid_address
      assert @teacher.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  # Test for rejecting invalid addresses
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @teacher.email = invalid_address
      assert_not @teacher.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  # Test for unique email addresses
  test "email addresses should be unique" do
    duplicate_user = @teacher.dup
    duplicate_user.email = @teacher.email.upcase
    @teacher.save
    assert_not duplicate_user.valid?
  end
  
  # Test for email addresses saving as all lowercase
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @teacher.email = mixed_case_email
    @teacher.save
    assert_equal mixed_case_email.downcase, @teacher.reload.email
  end
  
  # Tests if authenticated 
  # Author: Steven Royster & Meagan Moore
  test "authenticated? should return false for a teacher with nil digest" do
    assert_not @teacher.authenticated?(nil, nil)
  end
  
end