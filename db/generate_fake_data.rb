require 'open-uri'
require 'faker'

(1..25).each do |i|
  name = Faker::Name.unique.name.gsub(/\W/, '') # Remove non-word characters from the name
  User.create!(
    name: name,
    photo: "https://randomuser.me/api/portraits/men/#{i}.jpg",
    bio: Faker::Lorem.paragraph_by_chars(number: 200),
    posts_counter: 0,
    email: "#{name.downcase}@example.com",
    password: 'password', # Set a non-blank password
    password_confirmation: 'password' # Confirm the password
  )
end

(26..50).each do |i|
  name = Faker::Name.unique.name.gsub(/\W/, '') # Remove non-word characters from the name
  User.create!(
    name: name,
    photo: "https://randomuser.me/api/portraits/women/#{i - 25}.jpg",
    bio: Faker::Lorem.paragraph_by_chars(number: 200),
    posts_counter: 0,
    email: "#{name.downcase}@example.com",
    password: 'password', # Set a non-blank password
    password_confirmation: 'password' # Confirm the password
  )
end

User.all.each do |user|
  num_posts = rand(15..20)
  num_posts.times do
    Post.create!(
      title: Faker::Lorem.sentence,
      text: Faker::Lorem.paragraph_by_chars(number: 250),
      comments_counter: 0,
      likes_counter: 0,
      author_id: user.id
    )
  end
end

Post.all.each do |post|
  num_comments = rand(15..25)
  num_comments.times do
    Comment.create!(
      text: Faker::Lorem.sentence,
      post_id: post.id,
      author_id: User.pluck(:id).sample
    )
  end

  num_likes = rand(15..25)

  num_likes.times do
    Like.create!(
      post_id: post.id,
      author_id: User.pluck(:id).sample
    )
  end
end
