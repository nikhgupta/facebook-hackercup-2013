#!/usr/bin/env ruby
# encoding: utf-8
#

module Facebook
  module HackerCup2013
    class FindTheMin

      def initialize(input)
        @input = input
        @is_sample = File.basename(input) == "fbin.txt"
        @output = @is_sample ? "fbout.txt" : "realout.txt"
        @output = File.join(File.dirname(@input), @output)
        parse_problem
      end

      def parse_problem
        @cases = []
        lines = File.readlines(@input).map { |x| x.strip }
        @number_of_cases = lines.shift
        lines.each_slice(2) { |c| c = c.join(" "); @cases.push(c) }
      end

      def solve_all
        all = []
        @cases.each_with_index do |prob, index|
          all.push solve_case(prob, index)
          File.open(@output, "w") do |f|
            f.puts all.join("\n")
          end
        end
        puts all
      end

      def solve_case(prob, index)
        min = find_the_min prob
        "Case ##{index + 1}: #{min}"
      end

      def find_the_min(prob)
        prob = prob.split(" ").map { |i| i.to_i }
        m = []; cycle = []; counter = {}
        n = prob[0]; k = prob[1]; a = prob[2]
        b = prob[3]; c = prob[4]; r = prob[5]
        m[0] = a; counter[a] = 1
        
        # generate our array, and counter
        i = 1
        while i < k
          m[i] = ((m[i-1] * b) + c) % r
          counter[m[i]] = counter[m[i]] ? counter[m[i]] + 1 : 1
          i += 1
        end

        # get the values that are not present in this array
        # possible values of m[i] will always be less than k+1
        temp = (0..k).to_a - m

        # iterate to find the cycle
        # y will contain the cycle
        i = 0
        while i < k + 1
          # first value of 'temp' will always be minimum
          # so grab it and add to the end of our 'cycle'
          cycle.push(temp.shift)
          break if i == k
          shifted = m.shift
          if shifted < k+1 and counter[shifted] == 1
              # add this value to our temp array
              # and, sort it to bring minimum on surface
              # finally, remove this value from our 'counter'
              temp.push(shifted)
              temp = temp.sort
          else
            counter[shifted] -= 1
          end
          i += 1
        end
        return cycle[n % (k+1)]
      end
    end
  end
end

input = ARGV.shift
problem = Facebook::HackerCup2013::FindTheMin.new input
problem.solve_all
