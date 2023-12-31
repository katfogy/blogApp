require 'rails_helper'

describe 'Post Index Page Features', type: :feature, js: true do
  before :each do
    @user1 = User.create(
      name: 'Ruby Guy',
      photo: 'https://images.unsplash.com/photo-1696537768609-1cf03f53e893?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80',
      bio: 'user1 Pix',
      posts_count: 5
    )

    post1 = Post.create(id: 4, title: 'Post 1', text: 'text 1', likes_counter: 0, comments_counter: 0,
                        author_id: @user1.id)
    post2 = Post.create(id: 5, title: 'Post 2', text: 'text 2', likes_counter: 0, comments_counter: 0,
                        author_id: @user1.id)
    Post.create(id: 6, title: 'Post 3', text: 'text 3', likes_counter: 0, comments_counter: 0, author_id: @user1.id)
    Post.create(id: 7, title: 'Post 4', text: 'text 4', likes_counter: 0, comments_counter: 0, author_id: @user1.id)

    @user1.comments.create(text: 'comment 1', post: post1)
    @user1.comments.create(text: 'comment 2', post: post1)
    @user1.comments.create(text: 'comment 3', post: post2)

    @user1.likes.create(post: post1)
  end

  it 'can see the user\'s profile picture' do
    visit user_posts_path(@user1.id)
    expect(page).to have_css('.comment-bio-card')
  end

  it 'can see the user\'s username' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Ruby Guy')
  end

  it 'can see the number of posts the user has written' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Number of Posts: 4')
  end

  it 'can see the post\'s title' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Post 1')
  end

  it 'can see the post\'s body' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('text 4')
  end

  it 'can see the first comments of a post' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('comment 1')
  end

  it 'can see how many comments a post has' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Comments: 2')
  end

  it 'can see how many likes a post has' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Likes: 1')
    expect(page).to have_content('Likes: 0')
  end

  it 'can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user1.id)
    expect(page).to have_button('Pagination')
  end

  it 'When I click on a post, it redirects me to that post\'s show page' do
    visit user_posts_path(@user1.id)
    click_link(href: user_post_path(@user1.id, 6))
    expect(page).to have_current_path(user_post_path(@user1.id, 6))
  end
end
