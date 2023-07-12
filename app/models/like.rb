class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  private

  def likes_update
    post.increment!(:likes_counter)
  end
end
