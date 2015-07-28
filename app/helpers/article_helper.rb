module ArticleHelper

  def article_daterange(article)
    [article.begin_date, article.end_date]
    .map { |d| d.strftime '%Y/%m/%d' }.join ' - '
  end
end
