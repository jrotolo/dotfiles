#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'
require 'open-uri'

options = {}

opts = OptionParser.new do |o|
  o.on("--clean", "Delete everything before re-cloning") do
    options[:clean] = true
  end
end
opts.parse!

git_bundles = [
  "git://github.com/nanotech/jellybeans.vim.git",
  "git://github.com/tpope/Vim-vividchalk.git",
  "git://github.com/kien/ctrlp.vim.git",
  "git://github.com/pangloss/vim-javascript.git",
  "git://github.com/mxw/vim-jsx.git",
  "git://github.com/bling/vim-airline",
]

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

if options[:clean]
  puts "Trashing everything (lookout!)"
  Dir["*"].each do |d|
    FileUtils.rm_rf d
  end
end

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  if File.exists?(dir)
    puts "  Skipping #{dir}, as it already exists"
  else
    puts "  Unpacking #{url} into #{dir}"
    `git clone #{url} #{dir}`
    if $?.success?
      FileUtils.rm_rf(File.join(dir, ".git"))
    else
      STDERR.puts "Problem with #{url}"
    end
  end
end
 



        

   
        


