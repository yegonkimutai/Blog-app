require 'rails_helper'
RSpec.feature 'User show page' do
    before do
    @user = User.create(name: "user1", photo: "https://unsplash.com/photos/F_-0BxGuVvo", bio: 'Bio 1')
    @post1 = Post.create(author: @user, title: "Post 1", text: "Body of post 1")
    @post2 = Post.create(author: @user, title: "Post 2", text: "Body of post 2")
    @post3 = Post.create(author: @user, title: "Post 3", text: "Body of post 3")
    visit user_path(@user)
    end
    scenario "See the user's profile picture" do
        expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    end
    scenario "See the username of the user" do
        expect(page).to have_content(@user.name)
    end
    scenario "See the number of posts the user has written" do
        expect(page).to have_content(@user.posts.count)
    end
    scenario "See the bio of the user" do
        expect(page).to have_content(@user.bio)
    end
      scenario "I can see a button that lets me view all of a user's posts" do
        expect(page).to have_link("See all posts", href: user_posts_path(@user))
      end
end