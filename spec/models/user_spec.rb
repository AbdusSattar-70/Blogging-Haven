# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Abdus Sattar',
      photo: 'https://examples.jpg',
      bio: 'The command above will run all the tests available in your entire app',
      posts_counter: 0
    )
  end

  describe 'Associations' do
    it 'has many posts' do
      expect(subject).to have_many(:posts).with_foreign_key(:author_id).dependent(:destroy)
    end

    it 'has many likes' do
      expect(subject).to have_many(:likes).with_foreign_key(:author_id).dependent(:destroy)
    end

    it 'has many comments' do
      expect(subject).to have_many(:comments).with_foreign_key(:author_id).dependent(:destroy)
    end
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'is valid without a photo' do
      subject.photo = ''
      expect(subject).to be_valid
    end

    it 'is not valid when posts_counter is not an integer' do
      subject.posts_counter = 'kdkkd'
      expect(subject).to_not be_valid
    end

    it 'is not valid when posts_counter is less than 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#recent_posts method check' do
    before do
      5.times do |index|
        Post.create(
          title: "Post #{index}",
          text: "This is the text for post #{index}",
          author: subject,
          comments_counter: 0,
          likes_counter: 0
        )
      end
    end

    it 'should return the most recent 3 posts' do
      expect(subject.recent_posts.length).to eq(3)
    end
  end
end
