class Folder < ApplicationRecord
	belongs_to :user

	has_many :assets, :dependent => :destroy

	acts_as_tree
end
