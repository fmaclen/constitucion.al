page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :blog do |blog|
  blog.name = "nacion"
  blog.prefix = "constituciones/arg"
  blog.permalink = "argentina/{title}"
  blog.new_article_template = File.expand_path('../source/constituciones/template.erb', __FILE__)
end

activate :blog do |blog|
  blog.name = "ba"
  blog.prefix = "constituciones/ba"
  blog.permalink = "buenos-aires/{title}"
  blog.new_article_template = File.expand_path('../source/constituciones/template.erb', __FILE__)
end

activate :directory_indexes

configure :build do
end
