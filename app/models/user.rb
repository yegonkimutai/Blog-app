class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def display_posts
    posts.order(created_at: :desc).limit(3)
  end

  ROLES = %i[admin default].freeze

  def admin?
    role == 'admin'
  end

  def is?(requested_role)
    self.role = requested_role.to_s
  end
end
