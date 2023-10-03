require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin = User.create(username: "Sanevy", email: "sanevy@test.com", password: "asdf", admin: true)
    sign_in_as(@admin)
  end

  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: " "} }      
    end
    assert_select 'div.alert'
    assert_select 'ul' do
      assert_select 'li', "Name can't be blank"
    end    
  end
end
