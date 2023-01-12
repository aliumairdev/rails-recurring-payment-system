require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get managers_plans_index_url
    assert_response :success
  end
end
