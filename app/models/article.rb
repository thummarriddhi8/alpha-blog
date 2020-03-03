class Article < ApplicationRecord
	# Associations
	belongs_to :user

	# Validations
	validates :title, presence: true, length: { minimum: 3, maximum: 50 }
	validates :description, presence: true, length: { minimum: 10, maximum: 100 }
	validates :user_id, presence: true
end