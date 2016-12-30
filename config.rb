page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :blog do |blog|
  blog.name = "sf"
  blog.prefix = "constituciones/sf"
  blog.permalink = "santa-fe/embed/{title}"
  blog.new_article_template = File.expand_path('../source/constituciones/template.erb', __FILE__)
end

activate :blog do |blog|
  blog.name = "nacion"
  blog.prefix = "constituciones/arg"
  blog.permalink = "argentina/embed/{title}"
  blog.new_article_template = File.expand_path('../source/constituciones/template.erb', __FILE__)
end

activate :directory_indexes

configure :build do
end
