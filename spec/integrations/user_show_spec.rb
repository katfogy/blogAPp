require 'rails_helper'

describe 'User Show Page Features', type: :feature, js: true do
  before :each do
    @user1 = User.create(
      name: 'Ruby Guy',
      photo: 'https://images.unsplash.com/photo-1696537768609-1cf03f53e893?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80',
      bio: 'user1 Pix',
      posts_count: 5
    )

    Post.create(id: 4, title: 'Post 1', text: 'text 1', likes_counter: 0, comments_counter: 0, author_id: @user1.id)
    Post.create(id: 5, title: 'Post 2', text: 'text 2', likes_counter: 0, comments_counter: 0, author_id: @user1.id)
    Post.create(id: 6, title: 'Post 3', text: 'text 3', likes_counter: 0, comments_counter: 0, author_id: @user1.id)
  end

  it 'can see the username' do
    visit user_path(@user1.id)
    expect(page).to have_text('Ruby Guy')
  end

  it 'can see the user profile pic' do
    visit user_path(@user1.id)
    expect(page).to have_css('.profile')
  end

  it 'can see the number of posts the user has written' do
    visit user_path(@user1.id)
    expect(page).to have_all_of_selectors('.number-of-posts')
  end

  it 'can see the user\'s bio' do
    visit user_path(@user1.id)
    expect(page).to have_css('.user-card')
  end

  it 'can see the user\'s first 3 posts' do
    visit user_path(@user1.id)
    res = page.all('.user-posts')
    expect(res.length).to eq 3
  end

  it 'can see a button that lets me view all of a user\'s posts' do
    visit user_path(@user1.id)
    expect(page).to have_button('See All Posts')
  end

  it 'redirect to the post\'s show page' do
    visit user_path(@user1.id)
    click_link(href: user_post_path(@user1.id, 4))
    expect(page).to have_current_path(user_post_path(@user1.id, 4))
  end

  it 'redirects to the user\'s all posts page' do
    visit user_path(@user1.id)
    click_link(href: user_posts_path(@user1.id))
    expect(page).to have_current_path(user_posts_path(@user1.id))
  end
end
