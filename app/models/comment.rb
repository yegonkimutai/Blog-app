class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  has_many :likes, dependent: :destroy

  after_save :comments_update

  private

  def comments_update
    post.increment!(:comments_counter)
  end
end
