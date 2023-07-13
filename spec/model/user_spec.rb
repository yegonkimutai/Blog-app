require 'rails_helper'

RSpec.describe User, type: :model do
    subject { User.new(name: 'Henry', photo: 'photo1', bio: 'First photo', posts_counter: 1) }
    
    before{ subject.save }

    it 'name should be present' do
        expect(subject).to be_valid
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it 'post counter should be zero or more' do
        expect(subject.posts_counter).to be_a(Integer)
        expect(subject.posts_counter).to be >=0
        subject.posts_counter = -1
        expect(subject).to_not be_valid
    end

    it 'returns the latest 3 posts' do
      post1 = subject.posts.create!(created_at: 3.days.ago)
      post2 = subject.posts.create!(created_at: 2.days.ago)
      post3 = subject.posts.create!(created_at: 1.day.ago)
      post4 = subject.posts.create!(created_at: Time.now)

      expect(subject.display_posts).to eq([post4, post3, post2])
    end
end