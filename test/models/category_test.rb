require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
	# This method is always run before all the successive tests run
	def setup
		@category = Category.new(name: "sports")
	end

	test "category should be valid" do
		# Basically the following statement tests that can we create a new instance of Category and is it valid?
		assert @category.valid?
	end

	test "name should be present" do
		@category.name = " "
		assert_not @category.valid?
	end

	test "name should be unique" do
		@category.save
		category2 = Category.new(name: 'sports')
		assert_not category2.valid?
	end

	test "name should not be too long" do
		@category.name = "r" * 26
		assert_not @category.valid?
	end

	test "name should not be too short" do
		@category.name = "rr"
		assert_not @category.valid?
	end
end