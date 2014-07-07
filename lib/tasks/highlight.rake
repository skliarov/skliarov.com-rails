require 'fileutils'

desc 'Create nondigest versions of all highlight digest assets'
task :highlight do
  FileUtils.cp Rails.root.join('vendor/assets/javascripts/highlight/highlight.pack.js', ), Rails.root.join('public/assets'), verbose: true
  FileUtils.chmod 0777, Rails.root.join('public/assets/highlight.pack.js', )
end