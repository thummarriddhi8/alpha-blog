require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category_one = Category.create(name: 'food')
    @category_two = Category.create(name: 'lifestyle')
  end

  test "should show categories listing" do
    get categories_path
    assert_template 'categories/index'
    # To ensure that each category is listed with the links to go to their respective show pages
    assert_select "a[href=?]", category_path(@category_one), text: @category_one.name
    assert_select "a[href=?]", category_path(@category_two), text: @category_two.name
  end
end