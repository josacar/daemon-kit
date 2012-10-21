begin
  require 'tinder'
rescue LoadError
  $stderr.puts "Missing tinder gem. Please run 'bundle install'."
  exit 1
end
