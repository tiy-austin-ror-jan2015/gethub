require_relative 'lib/context'
require 'erb'

desc 'Compile all erb and scss files'
task :build => [:compile_scss, :compile_erb, :open] do
end

desc 'Compile scss files'
task :compile_scss do
  `sass app/scss/style.scss public/css/style.css`
  puts 'Sass compilation... Done'
end

desc 'Watch for changes and compile scss files'
task :watch_scss do
  puts 'Watching app/scss for file changes'
  `sass --watch app/scss:public/css`
end

desc 'Compile erb file'
task :compile_erb do
  template = open('./app/templates/index.html.erb').read
  context  = Context.new()#change to :live when finished
  binding  = context.get_binding

  compiled_html = ERB.new(template).result(binding)

  File.write('public/index.html', compiled_html)
  puts 'erb compilation... Done'
end

desc 'Open compiled site'
task :open do
  puts 'Opening index.html...'
  `open public/index.html`
end

task :default => [:build]
