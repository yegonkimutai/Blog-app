class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy

  after_save :update_posts

  def get_comments
    comments.order(created_at: desc).limit(5)
  end

  private
  def update_posts
    author.increment(:posts_counter)
  end
end
