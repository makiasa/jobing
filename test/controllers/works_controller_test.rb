require 'test_helper'

class WorksControllerTest < ActionDispatch::IntegrationTest
  test "should get flow" do
    get works_flow_url
    assert_response :success
  end

end
