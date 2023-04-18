require 'rails_helper'

require 'capybara/rspec'

RSpec.describe 'root page features' do
  before(:each) do
    users = [
      user1 = User.create(
        name: 'Fatima',
        photo: 'https://www.img2link.com/images/2023/04/13/c2bbea766ec481f3d798809dd39eedb6.png',
        bio: 'CEO Nairobi Hub',
        posts_counter: 3
      ),
      user2 = User.create(
        name: 'Melissa',
        photo: 'https://www.img2link.com/images/2023/04/13/8be05dd4a187ef00cf2ea2ae148cce70.png',
        bio: 'Teacher from Mexico.',
        posts_counter: 3
      ),
      user3 = User.create(
        name: 'Nick',
        photo: 'https://www.img2link.com/images/2023/04/13/7b7f0cbbd22a333073dde3961dce35d0.png',
        bio: 'A sofware developer from Kenya',
        posts_counter: 3
      )
    ]
     visit "/users/#{user.id}"
  end
  
  describe 'users#index' do
    it 'displays all the different usernames' do
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'display the profile picture for each user' do
      users.each do |user|
        expect(page).to have_css("img[src='#{user.photo}']")
      end
    end
    it 'displays number of posts for each user' do
      users.each do |user|
        expect(page).to have_content("Number of posts: #{user.posts_counter}")
      end
    end
    it 'redirects to user show page when clicked on user name' do
       visit "/users/#{user.id}"
      click_link users.first.name
      expect(current_path).to eq(user_path(users.first))
      expect(page).to have_content(users.first.name)
      expect(page).to have_css("img[src='#{users.first.photo}']")
      expect(page).to have_content(users.first.bio)
      expect(page).to have_content("Number of posts: #{users.first.posts_counter}")
    end
  end
end