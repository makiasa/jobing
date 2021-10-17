require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get todos_new_url
    assert_response :success
  end

end
