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

file = File.open(fileName, "r")

#TODO: fix this
while !file.eof?
  line = file.readline
  if line.include? "tcp_lat:"
    latLine = file.readline
    tcpLat.concat([latLine.split('=').last.split(' ').first])
  elsif line.include? "udp_lat:"
    latLine = file.readline
    udpLat.concat([latLine.split('=').last.split(' ').first])
  end
end


timestamp = Time.now.getutc

length = [tcpLat.length, udpLat.length].max
CSV.open("#{timestamp} latency.csv", "wb") do |csv|
  csv << ["tcp latency", "udp latency"]
  for i in 0..length
    tcpVal = nil
    udpVal = nil
    if(tcpLat.at(i))
      tcpVal = tcpLat.at(i)
    end
    if(udpLat.at(i))
      udpVal = udpLat.at(i)
    end
    if(tcpVal || udpVal)
      csv << [tcpVal, udpVal]
    end
  end
end
