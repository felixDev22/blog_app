require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get '/users/'
      expect(response).to be_successful
    end
  end
end
