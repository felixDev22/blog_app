require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get '/users/745/posts'
      expect(response).to be_successful
    end
  end
end

