module CommentsHelper
  def show_few_comments
    output = ''.html_safe
    @post.recent_comments.includes(:author).each do |comment|
      output += content_tag(:div, class: 'comment_div') do
        concat content_tag(:p, link_to(comment.author.name, user_path(comment.author)))
        concat content_tag(:p, comment.text, class: 'comment-text')
        concat(comment_delete_button(comment.author, @post, comment)) if can? :destroy, comment
      end
    end
    output
  end
end

def comment_delete_button(user, post, comment)
  button_to user_post_comment_path(user, post, comment),
            method: :delete,
            data: { confirm: 'Are you sure you want to delete it?' },
            class: 'delete-btn' do
    submit_tag 'Delete', title: 'delete comment', id: 'delete'
  end
end
