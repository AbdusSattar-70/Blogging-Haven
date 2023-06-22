class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  before_save :update_user_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments(limit=5)
    comments.order(created_at: :desc).limit(limit)
  end

  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count + 1)
  end
end
