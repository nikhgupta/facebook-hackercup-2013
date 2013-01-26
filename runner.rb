#!/usr/bin/env ruby
# encoding: utf-8

require 'highline/import'
require './say.rb'

Say = Facebook::HackerCup2013::Say

# numerical number for this problem
problem  = ARGV.shift
Say.aborted "I need a problem number to run!" unless problem

# get the directory for our problem
dir = File.expand_path(File.join(File.dirname(__FILE__), problem))

# first, check and ensure that the sample case runs
file    = File.join(dir, "problem.rb")
fbin    = File.join(dir, "fbin.txt")
fbout   = File.join(dir, "fbout.txt")
fbcheck = File.join(dir, "check.txt")
realin  = ARGV.shift || File.join(dir, "realin.txt")
realout = File.join(File.dirname(realin), "realout.txt")
loadtest= File.join(dir, "loadtest.txt")

puts realin, realout


# Run sample problem
Say.info "Running sample problem"

valid    = false
start    = Time.now
response = `ruby #{file} #{fbin}`
puts "=============================================="
puts response
puts "=============================================="

if File.exists?(fbout)
  fbout   = File.read fbout
  fbcheck = File.read fbcheck

  if (fbout == fbcheck)
    Say.success "Awesome!! Sample input produces sample output!"
    valid = true
  else
    Say.failed "Aww....|| Sample input does not produce correct output!"
  end
elsif not File.exists?(fbout)
  Say.failed "Failed to produce the sample output!"
else
  Say.failed "Failed while running the problem solver for test case!"
  exit 2
end
stop = Time.now
Say.info "Time elapsed #{(stop - start)*1000} milliseconds"

if valid and File.exists?(loadtest) and !File.exists?(realin)
  Say.info "Running Load Tests now.."
  start = Time.now
  number = 20

  (1..number).each do |i|
    response = `ruby #{file} #{loadtest}`
    if i == 1
      puts "=============================================="
      puts response
      puts "=============================================="
    end
  end

  stop = Time.now
  total = stop - start
  average = total / number
  if total < 10
    Say.success "Total Time elapsed #{(total)} seconds for #{number} tests"
    Say.success "Average Time elapsed #{(average)*1000} milliseconds for #{number} tests"
  else
    Say.failed "Total Time elapsed #{(total)} seconds for #{number} tests"
    Say.failed "Average Time elapsed #{(average)*1000} milliseconds for #{number} tests"
  end

  FileUtils.rm_rf(realout)

end

# if, an input file is given, run the solver and open the containing directory
if valid and File.exists?(realin)
  Say.info "Running actual problem..."
  start = Time.now
  response = `ruby #{file} #{realin}`
  puts "=============================================="
  puts response
  puts "=============================================="
  if response and File.exists?(realout)
    Say.success "Awesome!! Sample input produces sample output!"
  elsif not File.exists?(realout)
    Say.failed "Failed to produce the real output!"
  else
    Say.failed "Failed while running the problem solver for real case!"
  end
  stop = Time.now
  Say.info "Time elapsed #{(stop - start)*1000} milliseconds"

  `open #{File.dirname(realout)}` if File.exists?(realout)
elsif File.exists?(realin)
  Say.aborted "Not running real case, as sample case did not run successfully!"
  exit
end
