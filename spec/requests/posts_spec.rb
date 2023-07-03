require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index for each user posts list' do
    let(:user) { User.create(name: 'test user', photo: 'https://example.com', bio: 'test user bio', posts_counter: 0) }

    before :each do
      get user_posts_path(user)
    end

    it 'returns http success status' do
      expect(response).to have_http_status(:success)
    end

    it 'check http status code' do
      expect(response.status).to eq(200)
    end

    it 'includes the correct text placeholders in the response body' do
      expect(response.body).to include("Number of posts: 0")
    end

    it 'should render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show for a single post' do
    let(:user) { User.create(name: 'test user', photo: 'https://example.com', bio: 'test user bio', posts_counter: 0) }
    let(:post) { Post.create(title: 'test post', text: 'test text', comments_counter: 0, likes_counter: 0, author_id: user.id) }

    before :each do
      get user_post_path(user, post)
    end

    it 'should return success http status' do
      expect(response).to have_http_status(:success)
    end

    it 'check http status code' do
      expect(response.status).to eq(200)
    end

    it 'includes the correct text placeholders in the response body' do
      expect(response.body).to include('Add Like')
    end

    it 'should render show template' do
      expect(response).to render_template(:show)
    end
  end
end
