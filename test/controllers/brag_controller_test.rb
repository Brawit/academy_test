require "test_helper"

class BragControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get brag_url   # <- ต้องตรงกับ resource name
    assert_response :success
  end
end
