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
    visit "/users/#{@users.first.id}"
  end

  it 'displays the user name and profile image' do
    visit "/users/#{@users.first.id}"

    expect(page).to have_content(@users.first.name)
    expect(page).to have_content(@users.first.bio)
    expect(page.has_xpath?("//img[@src='#{@users.first.photo}']")).to be true
    expect(page).to have_content("Number of posts: #{@users.first.posts_counter}")
    expect(page).to have_button('See all posts')
  end

  it 'display the first 3 posts' do
    visit "/users/#{@users.first.id}"

    @users.first.posts.limit(3).each_with_index do |post, index|
      expect(page).to have_content("Post ##{index + 1}")
      expect(page).to have_content(post.text)
    end
  end

  it 'see all posts button redirects user to all of the posts' do
    visit "/users/#{@users.first.id}"

    expect(page).to have_button('See all posts')
    page.has_link?('See all posts')

    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(@users.first))
  end

  it 'redirects to particular post page when clicked' do
    visit "/users/#{@users.first.id}"
    page.first(:link, 'view post', visible: true).click if page.has_link?('view post')

    @users.first.posts.each do |post|
      post_id = post.id
      next unless page.has_link?('view post', href: user_post_path(@users.first, post_id))

      expect(current_path).to eq(user_post_path(@users.first, post_id))
    end
  end
end
