class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :questions
	has_many :answers
	has_many :likes, foreign_key: "liker_id", dependent: :destroy
	has_many :liked_answers, through: :likes, source: :liked, source_type: "Answer"

	def like?(answer)
	 likes.find_by(liked_id: answer.id)
	end

	def like!(answer)
	 likes.create!(liked_id: answer.id)
	end

	def unlike!(answer)
	 likes.find_by(liked_id: answer.id).destroy
	end       
end
