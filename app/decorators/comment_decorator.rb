class CommentDecorator < Draper::Decorator
  delegate_all
  include ActionView::Helpers::DateHelper
  def comment_info
    return nil unless object.created_at.present? && object.user.present?
    'Created ' + time_ago_in_words(object.created_at) + ', by ' + object.user.name
  end
end
