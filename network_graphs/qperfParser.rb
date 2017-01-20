#!/usr/bin/ruby
require 'csv'
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

#Holds tcp latency readings
tcpLat = Array.new
#Holds udp latency readings
udpLat = Array.new

lines = File.foreach(fileName).each_slice(2) do |lines|
  if(lines.select['tcp_lat'].any?)
    matches = lines.select {|line| line[/latency/i]}
    for match in matches
      tcplat.concat(match.split('=').last.split(' ').first)
    end
  elsif(lines.select['udp_lat'].any?)
    matches = lines.select {|line| line[/latency/i]}
    for match in matches
      udplat.concat(match.split('=').last.split(' ').first)
    end
  end
end

timestamp = Time.now.getutc

CSV.open("./#{timestamp} latency.csv", "wb") do |csv|
  csv << ["tcp latency", "udp latency"]
  for entry in tcpLat
    csv << [entry]
  end
end
