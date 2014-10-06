# Roundabout way to set a SASS variable based on an ENV variable:
#
# Defines a function which returns a custom option we pass to the SASS compiler
# and pass ENV["CUSTOMER"] to the sass compiler for the function to return. See
# css.scss for where we set the $customer variable.
module Sass::Script::Functions
  def customer
    Sass::Script::String.new(options[:custom][:customer])
  end
end

project_path = File.expand_path("../../..", File.dirname(__FILE__))
css_dir = "public"
sass_dir = "app/views/css"
images_dir = "public/images"
http_images_path = "/images"
javascripts_dir = "public/js"
fonts_dir = "public/fonts"
http_fonts_path = "/fonts"
# You can select your preferred output style here (can be overridden via the command line):
output_style = :nested
# True to show debugging comments showing original location of selector
line_comments = true

asset_cache_buster do |http_path, file|
  `md5sum #{file.path}`.split[0] if File.exists?(file.path)
end
