require 'test_helper'

class SharedfoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sharedfolder = sharedfolders(:one)
  end

  test "should get index" do
    get sharedfolders_url
    assert_response :success
  end

  test "should get new" do
    get new_sharedfolder_url
    assert_response :success
  end

  test "should create sharedfolder" do
    assert_difference('Sharedfolder.count') do
      post sharedfolders_url, params: { sharedfolder: { folder_id: @sharedfolder.folder_id, message: @sharedfolder.message, shared_email: @sharedfolder.shared_email, shared_user_id: @sharedfolder.shared_user_id, user_id: @sharedfolder.user_id } }
    end

    assert_redirected_to sharedfolder_url(Sharedfolder.last)
  end

  test "should show sharedfolder" do
    get sharedfolder_url(@sharedfolder)
    assert_response :success
  end

  test "should get edit" do
    get edit_sharedfolder_url(@sharedfolder)
    assert_response :success
  end

  test "should update sharedfolder" do
    patch sharedfolder_url(@sharedfolder), params: { sharedfolder: { folder_id: @sharedfolder.folder_id, message: @sharedfolder.message, shared_email: @sharedfolder.shared_email, shared_user_id: @sharedfolder.shared_user_id, user_id: @sharedfolder.user_id } }
    assert_redirected_to sharedfolder_url(@sharedfolder)
  end

  test "should destroy sharedfolder" do
    assert_difference('Sharedfolder.count', -1) do
      delete sharedfolder_url(@sharedfolder)
    end

    assert_redirected_to sharedfolders_url
  end
end
