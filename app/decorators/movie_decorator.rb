class MovieDecorator < Draper::Decorator
  delegate_all
  decorates_association :comment

  def cover
    "http://lorempixel.com/100/150/" +
      %w(abstract nightlife transport).sample +
      "?a=" + SecureRandom.uuid
  end
  def comment_info
    "Created " + time_ago_in_words(object.created_at) + ", by " + object.user.name
  end
end
