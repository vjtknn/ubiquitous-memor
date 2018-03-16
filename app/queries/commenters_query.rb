class CommentersQuery
  def initialize(relationship = User.all)
    @relationship = relationship
  end

  def fetch_top_commenters
    @relationship.joins(:comments)
                 .where('comments.created_at >= ?', 1.week.ago.midnight)
                 .select("users.name, count(comments.id) AS comment_count")
                 .group('users.name')
                 .order('comment_count desc')
                 .limit(10)
  end
end
