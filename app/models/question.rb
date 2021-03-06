class Question < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  has_many :answers
  has_many :comments, as: :commentable

  has_many :votes, as: :votable
  has_many :voters,  through: :votes, source: :voter

  validates :author, :title, :content, presence: true

  def vote_count
    votes.pluck(:count).reduce(:+) || 0
  end
end
