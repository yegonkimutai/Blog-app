require 'rails_helper'

RSpec.feature 'Post index page' do
    before do
    @user = User.create(name: "user1", photo: "https://unsplash.com/photos/F_-0BxGuVvo", bio: 'Bio 1')
    @post1 = Post.create(author: @user, title: "Post 1", text: "Body of post 1")
    @post2 = Post.create(author: @user, title: "Post 2", text: "Body of post 2")
    @comment1 = Comment.create(post: @post1, author: @user, text: "Comment 1 on Post 1")
    @comment2 = Comment.create(post: @post1, author: @user, text: "Comment 2 on Post 1")

    visit user_posts_path(@user)
    end

    scenario "See the user's profile picture" do
        expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
      end
    
      scenario "I can see the user's username" do
        expect(page).to have_content(@user.name)
      end
    
      scenario "See the number of posts the user has written" do
        expect(page).to have_content(@user.posts.count)
      end

      scenario "See a post's title" do
        expect(page).to have_content(@post1.title)
        expect(page).to have_content(@post2.title)
      end
    
      scenario "See the first comments on a post" do
        expect(page).to have_content(@comment1.text)
        expect(page).to have_content(@comment2.text)
      end
    
      scenario "See how many comments a post has" do
        expect(page).to have_content(@post1.comments.count)
      end
    
      scenario "I can see how many likes a post has" do
        likes_count = @post1.likes.count
        expect(page).to have_content("Likes: #{likes_count}")
      end

      scenario "I can see some of the post's body" do
        expect(page).to have_content(@post1.text)
        expect(page).to have_content(@post2.text)
      end
    
      scenario "I can see a section for pagination if there are more posts than fit on the view" do
        expect(page).to have_css(".pagination")
      end
    
      scenario "When I click on a post, it redirects me to that post's show page" do
        click_link @post1.title
        expect(current_path).to eq(user_post_path(@user, @post1.id))
      end
    
end