class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates :movie_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:movie_id]
  validates :content, presence: true, length: { minimum: 3, maximum: 250 }
end
