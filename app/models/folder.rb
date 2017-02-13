class Folder < ApplicationRecord
	belongs_to :user

	acts_as_tree
end
