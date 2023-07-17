require 'rails_helper'

RSpec.describe PostsController, type: :request do
    describe 'Get posts#index' do
        let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
        let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post')}

        it 'returns successful response' do
            get user_posts_path(user)
            expect(response).to have_http_status(:success)
        end

        it 'renders template' do
            get user_posts_path(user)
            expect(response).to render_template(:index)
        end
        
        it 'returns successful response' do
            get user_posts_path(user)
            expect(response.body).to include('Posts Available')
        end
    end

    describe 'Get posts#show' do
        let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
        let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post')}

        it 'returns successful response' do
            get user_post_path(user, post)
            expect(response).to have_http_status(:success)
        end

        it 'renders template' do
            get user_post_path(user, post)
            expect(response).to render_template(:show)
        end
        
        it 'returns successful response' do
            get user_post_path(user, post)
            expect(response.body).to include('Posts Available')
        end
    end
end