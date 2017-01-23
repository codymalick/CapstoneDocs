#!/usr/bin/ruby
require 'json'
require'csv'
require 'optparse'

fileName = nil

OptionParser.new do |opts|
  opts.banner = "Usage: iperfParser.rb [options]"
  opts.on("-f", "--file=FILE_INPUT", "file to read data from") do |f|
    if(f)
      fileName = f
    end
    opts.on("-h", "--help", "prints this help dialog") do |n|
      puts opts
      exit
    end
  end
end.parse!

if(fileName == nil)
  puts("Please provide a file with the \"-f\" option")
  exit
end

file = File.read(fileName)

dataHash = JSON.parse(file)

timestamp = Time.now.getutc.to_s.gsub! ':', '-'

CSV.open("./#{timestamp} bandwidth.csv", "wb") do |csv|
  csv << ["bits per second", "retransmits"]
  for interval in dataHash["intervals"].each
    bps = interval["sum"]["bits_per_second"]
    retrans = interval["sum"]["retransmits"]
    csv << [bps, retrans]
  end
end

