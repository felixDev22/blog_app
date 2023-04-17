require 'rails_helper'

require 'capybara/rspec'

RSpec.describe 'root page features' do
  before(:each) do
    @users = [
      @user1 = User.create(
        name: 'Fatima',
        photo: 'https://www.img2link.com/images/2023/04/13/c2bbea766ec481f3d798809dd39eedb6.png',
        bio: 'CEO Nairobi Hub',
        posts_counter: 0
      ),
      @user2 = User.create(
        name: 'Melissa',
        photo: 'https://www.img2link.com/images/2023/04/13/8be05dd4a187ef00cf2ea2ae148cce70.png',
        bio: 'Teacher from Mexico.',
        posts_counter: 0
      ),
      @user3 = User.create(
        name: 'Nick',
        photo: 'https://www.img2link.com/images/2023/04/13/7b7f0cbbd22a333073dde3961dce35d0.png',
        bio: 'A sofware developer from Kenya',
        posts_counter: 0
      )
    ]
    visit('/')
  end