#!/usr/bin/env ruby
# encoding: utf-8
#
require 'pry'

module Facebook
  module HackerCup2013
    class BalancedSmileys

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

      def solve_case(line, index)
        # puts line, "=" * line.length
        balanced = is_balanced?(line)
        # puts balanced.inspect
        "Case ##{index + 1}: #{balanced ? "YES" : "NO"}"
      end

      def is_balanced?(str)
        @arr = [0]
        str = str.gsub(/[a-z ]/, '')
        str.chars.each_with_index do |char, i|
          case char
          when "(" then replace_balance_counter( 1)
          when ")" then replace_balance_counter(-1)
          when ":" then @coloned = true
          else return false
          end

          # reject all negative values
          @arr = @arr.keep_if { |a| a >= 0 }
          return false if @arr.empty?
        end
        @arr.include?(0)
      end

      def replace_balance_counter(value)
        if @coloned
          @arr = @arr | @arr.map { |a| a + value }
        else
          @arr = @arr.map { |a| a + value }
        end
        @coloned = false
      end

    end
  end
end

input = ARGV.shift
problem = Facebook::HackerCup2013::BalancedSmileys.new input
problem.solve_all
