require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'Validations' do
    let(:user) { User.create(name: 'Abdus Sattar', posts_counter: 0) }
    subject do
      Post.new(author_id: user.id, title: 'This is a test title', text: 'This is my post', comments_counter: 1, likes_counter: 1)
    end

    it 'validates presence and length of title' do
      should validate_presence_of(:title)
      should validate_length_of(:title).is_at_most(250)
    end

    it 'validates numericality and non-negativity of comments_counter' do
      should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0)
    end

    it 'validates numericality and non-negativity of likes_counter' do
      should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0)
    end

    it 'updates the posts_counter of the author after saving' do
      expect { subject.save }.to change { user.reload.posts_counter }.by(1)
    end
  end

  describe 'Functionality' do
    let(:user) do
      User.create(
        name: 'John Doe',
        photo: 'https://example.jpg',
        bio: 'Hello, I am a test user',
        posts_counter: 0
      )
    end

    subject do
      Post.new(
        title: 'Test Post',
        text: 'This is a test post',
        author: user,
        comments_counter: 0,
        likes_counter: 0
      )
    end

    it 'returns the five most recent comments' do
      subject.save
      10.times do |i|
        Comment.create(
          text: "This is the text for comment #{i}",
          post: subject,
          author: user,
          created_at: Time.now - i.minutes # Adjust the timestamps for recent comments
        )
      end

      expect(subject.recent_comments.length).to eq(5)
    end

    it 'updates the posts_counter of the author after saving' do
      expect { subject.save }.to change { user.reload.posts_counter }.by(1)
    end
  end
end
