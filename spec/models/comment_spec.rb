require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post).with_foreign_key('post_id') }
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
  end

  describe 'callbacks' do
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
      Comment.new(
        post: post,
        author: user
      )
    end

    it 'updates the "comments_counter" of the post after saving a new comment' do
      expect { subject.save }.to change { post.reload.comments_counter }.by(1)
    end
  end
end
