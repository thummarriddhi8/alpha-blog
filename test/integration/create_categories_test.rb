require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'rachelzane', email: 'rachel@example.com', password: 'iamanamazinglawyer', admin: true) 
  end
  # Test to check that new form for category comes when you visit the new_category_path, and when informationis entered, it goes to create category method via post and retruns appropriate data on index page
  test "get new category form and create category" do
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      # HTTP Post request to the categories_path i.e. create categories
      post categories_path, params: { category: { name: "relationships" } }
      # Follow a single redirect response
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "relationships", response.body
  end

  # Test to ensure that incorrect data is not entered in category object and created
  test "invalid category submission results in failure" do
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      # HTTP Post request to the categories_path i.e. create categories
      post categories_path, params: { category: { name: " " } }
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end