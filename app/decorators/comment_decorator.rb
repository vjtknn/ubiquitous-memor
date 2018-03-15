class CommentDecorator < Draper::Decorator
  delegate_all
    def comment_info
      "Created " + time_ago_in_words(object.created_at) + ", by " + object.user.name
    end
end
