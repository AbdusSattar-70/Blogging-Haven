module PostsHelper
  def show_posts_comments_lists(posts)
    output = ''.html_safe
    posts.each do |post|
      output += content_tag(:div, class: 'postItem') do
        concat(content_tag(:div, class: 'title_div') do
          concat content_tag(:h3, post.title)
          concat content_tag(:span, link_to('See Details', user_post_path(post.author, post)))
        end)
        concat content_tag(:p, post.text)
        concat content_tag(:p, "Comments: #{post.comments_counter} Likes: #{post.likes_counter}")
        concat display_comments(post.recent_comments)
      end
    end
    output
  end

  def display_comments(comments)
    comments_html = comments.map do |comment|
      content_tag(:p) do
        "#{comment.author.name}: #{comment.text}"
      end
    end
    safe_join(comments_html)
  end
end
