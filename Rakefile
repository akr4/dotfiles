require 'rake'

task :install do
  Dir['*'].each do |file|
    next if %W[Rakefile].include? file

    dotfile= ENV['HOME'] + "/.#{file}"
    if File.exists?(dotfile)
      puts "skipping #{dotfile}"
    else
      puts "creating link #{dotfile}"
      system %Q{ln -s "$PWD/#{file}" #{dotfile}}
    end
  end
end

