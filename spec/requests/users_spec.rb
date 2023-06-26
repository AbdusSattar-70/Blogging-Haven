require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before :each do
      get users_path
    end
    it 'returns http success status' do
      expect(response).to have_http_status(:success)
    end
    it 'check http status code' do
      expect(response.status).to eq(200)
    end
    it 'includes the correct text placeholders in the response body ' do
      expect(response.body).to include('All users lists will show here')
    end
    it 'should render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'User => GET/users/id => #show' do
    before :each do
      get '/users/id'
    end
    it 'should return success http status' do
      expect(response).to have_http_status(:success)
    end
    it 'check http status code' do
      expect(response.status).to eq(200)
    end
    it 'includes the correct text placeholders in the response body ' do
      expect(response.body).to include('Each user details will show here')
    end
    it 'should render index template' do
      expect(response).to render_template(:show)
    end
  end
end
