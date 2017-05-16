require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include Devise::Test

  test "the truth" do
    assert true
  end

  test "user has email" do
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    assert users(:one).email == "user1@test.com"
  end

  test "test user has nil password initially" do
    assert_nil users(:one).password 
  end

  # TODO - determine method for setting password
  # test "test user can add password" do
  #   users(:one)
  # end
end

