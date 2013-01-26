#!/usr/bin/env ruby
# encoding: utf-8

module Facebook
  module HackerCup2013
    class BeautifulStrings

      def initialize(input)
        @input = input
        @is_sample = File.basename(input) == "fbin.txt"
        @output = @is_sample ? "fbout.txt" : "realout.txt"
        @output = File.join(File.dirname(@input), @output)
        parse_problem
      end

      def parse_problem
        lines = File.readlines(@input).map { |x| x.strip }
        @number_of_cases = lines.shift
        @cases = lines
      end

      def solve_all
        all = []
        @cases.each_with_index do |line, index|
          all.push solve_case(line, index)
          File.open(@output, "w") do |f|
            f.puts all.join("\n")
          end
        end
        puts all
      end

      def solve_case(line, index = 0)
        chars  = {}
        total_beauty = 0
        line.downcase.gsub(/\W+/, '').chars.each do |c|
          chars[c] = chars.has_key?(c) ? chars[c] + 1 : 1
        end

        current_beauty = 26
        chars.sort_by{|char,freq| freq}.reverse.each do |char_with_freq|
          total_beauty += char_with_freq[1] * current_beauty
          current_beauty -= 1
        end

        "Case ##{index + 1}: #{total_beauty}"
      end
    end
  end
end

input = ARGV.shift
problem = Facebook::HackerCup2013::BeautifulStrings.new input
problem.solve_all
