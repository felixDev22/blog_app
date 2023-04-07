require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it 'name should be present' do
      user = User.new(name: 'Bazu', photo: 'http//:www.unsplash.com', bio: 'A doctor with 12years experience')
      expect(user.valid?).to eq(true)
    end

    it 'name should not be empty' do
      user = User.new(name: '', photo: 'http//:www.unsplash.com', bio: 'A doctor with 12years experience')
      expect(user.valid?).to eq(false)
    end

    it 'posts_counter should be greater than or equal to zero' do
      user = User.new(name: 'Bazu', photo: 'http//:www.unsplash.com', bio: 'A doctor with 12years experience')
      expect(user.posts_counter).to be >= 0
    end
  end

  describe "#recent_posts" do
    let(:user) { User.create(name: 'Bazu', photo: 'http//:www.unsplash.com', bio: 'A doctor with 12years experience') }

    it "returns up to 3 posts, ordered by created_at in descending order" do
      post1 = Post.create(title: "Test Post 1", author: user, created_at: Time.now)
      post2 = Post.create(title: "Test Post 2", author: user, created_at: Time.now - 1.day)
      post3 = Post.create(title: "Test Post 3", author: user, created_at: Time.now - 2.days)
      post4 = Post.create(title: "Test Post 4", author: user, created_at: Time.now - 3.days)
      post5 = Post.create(title: "Test Post 5", author: user, created_at: Time.now - 4.days)
      post6 = Post.create(title: "Test Post 6", author: user, created_at: Time.now - 5.days)

      expect(user.recent_posts).to eq([post1, post2, post3])
    end
  end
end
