require 'test_helper'

class UploadfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @uploadfile = uploadfiles(:one)
  end

  test "should get index" do
    get uploadfiles_url
    assert_response :success
  end

  test "should get new" do
    get new_uploadfile_url
    assert_response :success
  end

  test "should create uploadfile" do
    assert_difference('Uploadfile.count') do
      post uploadfiles_url, params: { uploadfile: { folder_id: @uploadfile.folder_id } }
    end

    assert_redirected_to uploadfile_url(Uploadfile.last)
  end

  test "should show uploadfile" do
    get uploadfile_url(@uploadfile)
    assert_response :success
  end

  test "should get edit" do
    get edit_uploadfile_url(@uploadfile)
    assert_response :success
  end

  test "should update uploadfile" do
    patch uploadfile_url(@uploadfile), params: { uploadfile: { folder_id: @uploadfile.folder_id } }
    assert_redirected_to uploadfile_url(@uploadfile)
  end

  test "should destroy uploadfile" do
    assert_difference('Uploadfile.count', -1) do
      delete uploadfile_url(@uploadfile)
    end

    assert_redirected_to uploadfiles_url
  end
end
