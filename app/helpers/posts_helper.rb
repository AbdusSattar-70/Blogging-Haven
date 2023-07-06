module PostsHelper
  def show_posts_comments_lists(posts)
    output = ''.html_safe
    posts.includes(:author).each do |post|
      output += content_tag(:div, class: 'postItem') do
        concat(content_tag(:div, class: 'title_div') do
          concat content_tag(:h3, post.title)
          concat content_tag(:span, link_to('See Details', user_post_path(post.author, post)))
          concat post_delete_button(post.author, post) if can? :destroy, post
        end)
        concat content_tag(:p, post.text)
        concat content_tag(:p, "Comments: #{post.comments_counter} Likes: #{post.likes_counter}", class: 'bold_text')
        concat(content_tag(:div, class: 'comments_div') do
          concat display_comments(post.recent_comments)
        end)
      end
    end
    output
  end

  def display_comments(comments)
    comments_html = comments.includes(:author).map do |comment|
      content_tag(:p) do
        "#{comment.author.name}: #{comment.text}"
      end
    end
    safe_join(comments_html)
  end
end

def post_delete_button(user, post)
  button_to "/users/#{user.id}/posts/#{post.id}",
            method: :delete,
            data: { confirm: 'Are you sure you want to delete it?' },
            class: 'delete-btn' do
    submit_tag 'Delete', title: 'delete post', id: 'delete'
  end
end
