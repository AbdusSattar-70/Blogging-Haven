class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  before_save :set_default_posts_counter

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  private

  def set_default_posts_counter
    self.posts_counter ||= 0
  end
end
