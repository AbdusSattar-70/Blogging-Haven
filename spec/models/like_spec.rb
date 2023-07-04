require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validation' do
    subject { Like.new }

    before { subject.save }

    it 'requires the "likes" text to contain content' do
      expect(subject).to_not be_valid
    end
  end

  describe 'functionality' do
    let(:user) do
      User.create(
        name: 'John Doe',
        photo: 'https://examples.jpg',
        bio: 'Hello, I am a test user',
        posts_counter: 0
      )
    end

    let(:post) do
      Post.create(
        title: 'Test Post',
        text: 'This is a test post',
        author: user,
        comments_counter: 0,
        likes_counter: 0
      )
    end

    subject do
      Like.new(
        user: user,
        post: post
      )
    end

    it 'updates the "likes_counter" of the post after creating a new like' do
      expect { subject.save }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
