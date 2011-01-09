require 'test_helper'

class DeveloperNotesControllerTest < ActionController::TestCase
  setup do
    @developer_note = developer_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:developer_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create developer_note" do
    assert_difference('DeveloperNote.count') do
      post :create, :developer_note => @developer_note.attributes
    end

    assert_redirected_to developer_note_path(assigns(:developer_note))
  end

  test "should show developer_note" do
    get :show, :id => @developer_note.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @developer_note.to_param
    assert_response :success
  end

  test "should update developer_note" do
    put :update, :id => @developer_note.to_param, :developer_note => @developer_note.attributes
    assert_redirected_to developer_note_path(assigns(:developer_note))
  end

  test "should destroy developer_note" do
    assert_difference('DeveloperNote.count', -1) do
      delete :destroy, :id => @developer_note.to_param
    end

    assert_redirected_to developer_notes_path
  end
end
