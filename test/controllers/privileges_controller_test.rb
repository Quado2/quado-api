require "test_helper"

class PrivilegesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @privilege = privileges(:one)
  end

  test "should get index" do
    get privileges_url, as: :json
    assert_response :success
  end

  test "should create privilege" do
    assert_difference("Privilege.count") do
      post privileges_url, params: { privilege: { create: @privilege.create, delete: @privilege.delete, edit: @privilege.edit, mod_id: @privilege.mod_id, role_id: @privilege.role_id, update: @privilege.update } }, as: :json
    end

    assert_response :created
  end

  test "should show privilege" do
    get privilege_url(@privilege), as: :json
    assert_response :success
  end

  test "should update privilege" do
    patch privilege_url(@privilege), params: { privilege: { create: @privilege.create, delete: @privilege.delete, edit: @privilege.edit, mod_id: @privilege.mod_id, role_id: @privilege.role_id, update: @privilege.update } }, as: :json
    assert_response :success
  end

  test "should destroy privilege" do
    assert_difference("Privilege.count", -1) do
      delete privilege_url(@privilege), as: :json
    end

    assert_response :no_content
  end
end
