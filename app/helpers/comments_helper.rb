module CommentsHelper
  def show_few_comments
    output = ''.html_safe
    @post.recent_comments.each do |comment|
      output += content_tag(:div, class: 'comment') do
        concat content_tag(:p, link_to(comment.author.name, user_path(@user)))
        concat content_tag(:div, comment.text, class: 'comment-text')
      end
    end
    output
  end
end
