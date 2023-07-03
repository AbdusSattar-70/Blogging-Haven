require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Mondol', photo: 'https://example.jpg',
                         bio: 'He is a software engineer from Bangladesh', posts_counter: 1)
    @user2 = User.create(name: 'Sattar', photo: 'https://example.jpg',
                         bio: 'He is a student of Microverse full-stack program', posts_counter: 90)
    @user3 = User.create(name: 'Karim', photo: 'https://example.jpg',
                         bio: 'Teacher from Jamalpur bus stand', posts_counter: 6)
    visit users_path
  end

  it 'I can see the username of all other users.' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
    expect(page).to have_content(@user3.name)
  end
  it 'I can see the profile picture for each user.' do
    expect(page.html).to include(@user1.photo)
    expect(page.html).to include(@user2.photo)
    expect(page.html).to include(@user3.photo)
  end

  it 'I can see the number of posts each user has written.' do
    expect(page.html).to have_content(@user1.posts_counter)
    expect(page.html).to have_content(@user2.posts_counter)
    expect(page.html).to have_content(@user3.posts_counter)
  end

  it 'When I click on a user, I am redirected to that users show page.' do
    click_on @user2.name
    expect(current_path).to eq("/users/#{@user2.id}")
  end
end
