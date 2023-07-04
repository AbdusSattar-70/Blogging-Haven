require 'rails_helper'

RSpec.describe 'Post #Show Page', type: :feature do
    before(:each) do
      @user = User.create(name: 'Mondol', photo: 'https://example.jpg',
                          bio: 'He is a software engineer from Bangladesh', posts_counter: 10)
      @post = Post.create(author: @user, title: 'test post', text: 'This is my first post', likes_counter: 15,
                          comments_counter: 10)
      @comment = Comment.create(post_id: @post.id, author_id: @user.id, text: 'test comment')
      visit user_post_path(@user, @post)
    end

    it 'I can see the post\'s title.' do
      page.has_content?(@post.title)
    end
    it 'I can see who wrote the post.' do
      page.has_content?(@post.author)
    end
    it 'I can see how many comments it has.' do
      page.has_content?(@post.comments_counter)
    end

    it 'I can see how many likes it has.' do
        page.has_content?(@post.likes_counter)
      end
    
      it 'I can see the post body.' do
        page.has_content?(@post.text)
      end
  end