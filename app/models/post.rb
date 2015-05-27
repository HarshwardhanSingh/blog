class Post < ActiveRecord::Base
	belongs_to :user
	acts_as_likeable
end

