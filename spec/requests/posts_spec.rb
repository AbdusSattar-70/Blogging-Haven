require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index each user posts lists' do
    before :each do
      get '/users/id/posts'
    end
    it 'returns http success status' do
      expect(response).to have_http_status(:success)
    end
    it 'check http status code' do
      expect(response.status).to eq(200)
    end
    it 'includes the correct text placeholders in the response body ' do
      expect(response.body).to include("Each User's all posts will show here")
    end
    it 'should render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'Post => GET/single post => #show' do
    before :each do
      get '/users/id/posts/id'
    end
    it 'should return success http status' do
      expect(response).to have_http_status(:success)
    end
    it 'check http status code' do
      expect(response.status).to eq(200)
    end
    it 'includes the correct text placeholders in the response body ' do
      expect(response.body).to include('Each post details will show here')
    end
    it 'should render index template' do
      expect(response).to render_template(:show)
    end
  end
end
