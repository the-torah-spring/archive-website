require "rubygems"
require "bundler/setup"
require "stringex"

## -- Config -- ##

posts_dir    = "_posts"
new_post_ext = "markdown"


# usage rake new_issue
desc "Create a new issue in #{posts_dir}"
task :new_issue, :title do |t, args|
  if args.title
    title = args.title
  else
    title = get_stdin("Enter a title for your post: ")
  end
  filename = "#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.#{new_post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  tags = get_stdin("Enter tags to classify your post (comma separated): ")
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "modified: #{Time.now.strftime('%Y-%m-%d %H:%M:%S %z')}"
    post.puts "tags: [#{tags}]"
    post.puts "image:"
    post.puts "  feature: "
    post.puts "  credit: "
    post.puts "  creditlink: "
    post.puts "comments: "
    post.puts "share: "
    post.puts "---"
  end
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end

def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end
