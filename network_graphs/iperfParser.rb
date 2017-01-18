#!/usr/bin/ruby
require 'json'
require'csv'

fileName = "testData.json"
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

