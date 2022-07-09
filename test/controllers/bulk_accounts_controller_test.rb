require "test_helper"

class BulkAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bulk_accounts_new_url
    assert_response :success
  end
end
