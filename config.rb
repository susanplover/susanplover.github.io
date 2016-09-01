activate :directory_indexes
###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

set :markdown_engine, :redcarpet
# With alternative layout
#
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

data.collections.collection_nav.each do |collection_data|
  proxy "#{collection_data[0].downcase.gsub("_", "-")}/index.html",
    "collection.html",
    locals: { collection_data: collection_data },
    ignore: true
end
ignore "/collection.html.erb"


# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###
helpers do
  def make_collection_title(data)
    data.split(/ |\_/).map(&:capitalize).join(" ")
  end

  def nav_active(nav_item, path, options: "")
    "#{nav_item.gsub("/", "")}#{options}" == path ? "active" : nil
  end

  def change_to_url(item)
    item.gsub("_", "-").prepend("/")
  end

  def image_title(piece)
    "#{piece.title} #{piece.details} #{piece.gallery}"
  end

  def go_make_thumbnail_url(url)
    "/thumbnails#{url}"
  end
end

# Build-specific configuration
configure :build do
  activate :gzip
  # Minify CSS on build
  activate :minify_css
  # Minify Javascript on build
  activate :minify_javascript
end

