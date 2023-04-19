require 'rails_helper'

RSpec.feature 'PostIndex', type: :feature do
  let(:user) do
    User.create(
      name: 'Fatima',
      photo: 'https://www.img2link.com/images/2023/04/13/c2bbea766ec481f3d798809dd39eedb6.png',
      bio: 'CEO Nairobi Hub', posts_counter: 2
    )
  end

  let!(:post1) do
    user.posts.create(title: 'Post 1', text: 'Life of single man', comments_counter: 2, likes_counter: 3)
  end
  let!(:post2) { user.posts.create(title: 'Post 2', text: 'Man need money', comments_counter: 2, likes_counter: 5) }

  before do
    visit user_posts_path(user)
  end

  it 'displays the author name' do
    expect(page).to have_content('Fatima')
  end

  it 'display total comments and likes for the post' do
    expect(page).to have_content(post1.comments_counter)
    expect(page).to have_content(post1.likes_counter)
  end

  it 'displays the post titles' do
    expect(page).to have_content(user.posts.first.title)
    expect(page).to have_content(user.posts.second.title)
  end

  it 'displays the total number of posts' do
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it 'displays the post author and creation date' do
    expect(page).to have_content(post1.text)
    expect(page).to have_content(post2.text)
  end

  it 'has a link to view each post' do
    expect(page).to have_link(href: user_post_path(user.id, post1.id))
    expect(page).to have_link(href: user_post_path(user.id, post2.id))
  end
end
