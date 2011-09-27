require 'rake'
require 'erb'
require_relative 'config'

task :install do
  Dir['*'].each do |file|
    next if %W[Rakefile config.rb].include? file

    dotfile= to_dotfile(file)

    if File.exists?(dotfile)
      puts "skipping #{dotfile}"
    else
      link_file(file)
    end
  end
end

def to_dotfile(file)
  ENV['HOME'] + "/.#{file.sub('.erb', '')}"
end

def link_file(file)
  dotfile = to_dotfile(file)
  if file =~ /.erb$/
    puts "generating #{dotfile}"
    File.open(dotfile, 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking #{dotfile}"
    system %Q{ln -s "$PWD/#{file}" #{dotfile}}
  end
end

