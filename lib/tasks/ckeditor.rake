require 'fileutils'

desc "Create nondigest versions of all ckeditor digest assets"
task "assets:precompile" do
  fingerprint = /\-[0-9a-f]{32}\./
  for file in Dir["public/assets/ckeditor/**/*"]
    next unless file =~ fingerprint
    nondigest = file.sub fingerprint, '.'
    FileUtils.cp file, nondigest, verbose: true
  end
end
Also I had to add an extra line to my application.rb file from what you have above so that assets:precompile included all the image assets needed by ckeditor.

config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
config.assets.precompile += Ckeditor.assets
config.assets.precompile += %w(ckeditor/*)