require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'root page features' do
  before(:each) do
    @users = [
      User.create(
        name: 'Fatima',
        photo: 'https://www.img2link.com/images/2023/04/13/c2bbea766ec481f3d798809dd39eedb6.png',
        bio: 'CEO Nairobi Hub',
        posts_counter: 3
      ),
      User.create(
        name: 'Melissa',
        photo: 'https://www.img2link.com/images/2023/04/13/8be05dd4a187ef00cf2ea2ae148cce70.png',
        bio: 'Teacher from Mexico.',
        posts_counter: 3
      ),
      User.create(
        name: 'Nick',
        photo: 'https://www.img2link.com/images/2023/04/13/7b7f0cbbd22a333073dde3961dce35d0.png',
        bio: 'A software developer from Kenya',
        posts_counter: 0
      )
    ]
    @user = @users.first
    visit "/users/#{@users.first.id}"
  end

  it 'displays the user name and profile image' do
    visit "/users/#{@users.first.id}"

    expect(page).to have_content(@users.first.name)
    expect(page).to have_content(@users.first.bio)
    expect(page.has_xpath?("//img[@src='#{@users.first.photo}']")).to be true
    expect(page).to have_content("Number of posts: #{@users.first.posts_counter}")
  end

  it 'display the first 3 posts' do
    visit "/users/#{@users.first.id}"

    @users.first.posts.limit(3).each_with_index do |post, index|
      expect(page).to have_content("Post ##{index + 1}")
      expect(page).to have_content(post.text)
    end
  end

  it 'displays a section for pagination' do
    @user.posts.create(title: 'Post 6', text: 'First Time Home Buyer Tips', comments_counter: 2, likes_counter: 3)
    @user.posts.create(title: 'Post 7', text: 'Job interview tips', comments_counter: 2, likes_counter: 5)
    @user.posts.create(title: 'Post 8', text: 'Nature Photography', comments_counter: 3, likes_counter: 1)
    @user.posts.create(title: 'Post 9', text: 'Preparing for a marathon', comments_counter: 1, likes_counter: 2)
    @user.posts.create(title: 'Post 10', text: 'Favorite cooking recipes', comments_counter: 0, likes_counter: 7)
    visit user_posts_path(@user)
    expect(page).to have_selector('.will-paginate-container')
  end
end
