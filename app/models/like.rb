class Like < ApplicationRecord
	belongs_to :liker, class_name: "User"
	belongs_to :liked, class_name: "Answer"
	validates :liker_id, presence: true
	validates :liked_id, presence: true
end
