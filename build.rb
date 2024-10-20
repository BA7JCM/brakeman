#!/usr/bin/env ruby
require 'fileutils'
bundle_exclude = %w[io-console racc strscan]

puts 'Packaging Brakeman gem...'

system 'rm -rf bundle Gemfile.lock brakeman-*.gem' and
  system 'BM_PACKAGE=true bundle install --standalone'

abort "No bundle installed" unless Dir.exist? 'bundle'

File.delete "bundle/bundler/setup.rb"
Dir.delete "bundle/bundler"

File.open "bundle/load.rb", "w" do |f|
  f.puts "path = File.expand_path('../..', __FILE__)"

  Dir["bundle/ruby/**/lib"].each do |dir|
    unless bundle_exclude.any? { |gem_name| dir.include? gem_name }
      f.puts %Q[$:.unshift "\#{path}/#{dir}"]
    end
  end
end

system "BM_PACKAGE=true gem build brakeman.gemspec"
