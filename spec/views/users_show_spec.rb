require 'rails_helper'

require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
end

RSpec.describe 'root page features' do
  before(:each) do
    @users = [
      User.create(
        name: 'Fatima',
        photo: 'https://www.img2link.com/images/2023/04/13/c2bbea766ec481f3d798809dd39eedb6.png',
        bio: 'CEO Nairobi Hub',
        posts_counter: 0
      ),
      User.create(
        name: 'Melissa',
        photo: 'https://www.img2link.com/images/2023/04/13/8be05dd4a187ef00cf2ea2ae148cce70.png',
        bio: 'Teacher from Mexico.',
        posts_counter: 0
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

end
