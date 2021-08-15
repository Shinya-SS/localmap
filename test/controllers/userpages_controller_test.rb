require 'test_helper'

class UserpagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get userpages_index_url
    assert_response :success
  end

end
