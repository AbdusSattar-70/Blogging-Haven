module UsersHelper
  def render_user_profiles
    output = ''.html_safe
    output += content_tag(:div, class: 'user') do
      @users.each do |user|
        concat content_tag(:img, nil, class: 'userImg', src: user.photo)
        concat(content_tag(:div, class: 'usernamePostCount') do
          concat content_tag(:h2, link_to(user.name, user_path(user)), class: 'username')
          concat content_tag(:p, "Number of posts: #{user.posts_counter}", class: 'postCount')
        end)
      end
    end
    output
  end

  def show_single_user(user)
    content_tag(:div, class: 'user') do
      concat image_tag(user.photo, class: 'userImg')
      concat(content_tag(:div, class: 'usernamePostCount') do
        concat content_tag(:h2, link_to(user.name, user_path(user)), class: 'username')
        concat content_tag(:p, "Number of posts: #{user.posts_counter}", class: 'postCount')
      end)
    end
  end

  def show_recent_posts(recent_posts, user)
    content_tag(:div, class: 'posts') do
      recent_posts.each do |post|
        concat(content_tag(:div, class: 'postItem') do
          concat(content_tag(:h3) do
            concat post.title
            concat link_to('see details', user_post_path(user, post))
          end)
          concat content_tag(:p, post.text)
          concat(content_tag(:p, class: 'comments_counter') do
            concat "Comments: #{post.comments_counter} Likes: #{post.likes_counter}"
          end)
        end)
      end
    end
  end
end
