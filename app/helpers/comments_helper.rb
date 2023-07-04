# frozen_string_literal: true

module CommentsHelper
  def show_few_comments
    output = ''.html_safe
    @post.recent_comments.includes(:author).each do |comment|
      output += content_tag(:div, class: 'comment_div') do
        concat content_tag(:p, link_to(comment.author.name, user_path(@user)))
        concat content_tag(:p, comment.text, class: 'comment-text')
      end
    end
    output
  end
end
