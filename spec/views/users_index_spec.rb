require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'UsersIndices', type: :feature do
  let!(:user) { User.create(name: 'Fatima', photo: 'https://www.img2link.com/images/2023/04/13/c2bbea766ec481f3d798809dd39eedb6.png', posts_counter: 0) }

  def image_exists?(url)
    response = Net::HTTP.get_response(URI.parse(url))
    response.code == '200'
  rescue StandardError
    false
  end

  it 'displays the user name and profile image on the index page' do
    visit '/users'

    expect(page).to have_content(user.name)
    expect(image_exists?(user.photo)).to be true
    expect(page).to have_content("Number of posts: #{user.posts_counter}")

    profile_link = page.find("a[href='#{user_path(user.id)}']", text: 'View_details')
    profile_link.click

    expect(current_path).to eq(user_path(user.id))
  end
end
