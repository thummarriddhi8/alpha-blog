require 'test_helper'
class CategoriesControllerTest < ActionDispatch::IntegrationTest
	def setup
		@category = Category.create(name: 'health')
		@user = User.create(username: 'rachelzane', email: 'rachel@example.com', password: 'iamanamazinglawyer', admin: true)
	end

	test "should get index" do
		get categories_path
		assert_response :success
	end

	test "should get new" do
		# Simulate the login process for admin so that only admin can access new method
		sign_in_as(@user, 'iamanamazinglawyer')
		get new_category_path
		assert_response :success
	end

	test "should get show" do
		get category_path(@category)
		assert_response :success
	end

	# Only logged in admin should be able to create categories
	test "should redirect create when admin not logged in" do
		assert_no_difference 'Category.count' do
			post categories_path, params: { category: {name: 'sports'}}
		end
		assert_redirected_to categories_path
	end
end