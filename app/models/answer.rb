class Answer < ApplicationRecord
	belongs_to :question
	belongs_to :user
	has_many :likes, foreign_key: "liked_id",
	                 class_name:  "Like",
	                 dependent:   :destroy
	has_many :likers, through: :likes, source: :liker
end
