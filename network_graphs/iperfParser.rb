#!/usr/bin/ruby
require 'json'
require'csv'
require 'optparse'

fileName = "testData.json"

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: iperfParser.rb [options]"
  opts.on("-f", "--file=FILE_INPUT", "file to read data from") do |f|
    if(f)
      fileName = f
    end
  end
  opts.on("-h", "--help", "prints this help dialog") do |n|
    puts opts
    exit
  end
end.parse!


file = File.read(fileName)

dataHash = JSON.parse(file)

CSV.open("./bandwidth.csv", "wb") do |csv|
  csv << ["bits per second", "retransmits"]
  for interval in dataHash["intervals"].each
    bps = interval["sum"]["bits_per_second"]
    retrans = interval["sum"]["retransmits"]
    csv << [bps, retrans]
  end
end

