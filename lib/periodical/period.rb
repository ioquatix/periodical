# Copyright, 2012, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Periodical
	class Period
		VALID_UNITS = [:days, :weeks, :months, :years]
		
		# Accepts strings in the format of "2 weeks" or "weeks"
		def self.parse(value)
			if Array === value
				parts = value
			else
				parts = value.to_s.split(/\s+/, 2)
			end
			
			if parts.size == 1
				if parts[0].to_i == 0
					count = 1
					unit = parts[0].to_sym
				else
					count = parts[0].to_i
					unit = :days
					
					if count == 7
						count = 1
						unit = :weeks
					end
					
					if count == 365
						count = 1
						unit = :years
					end
				end
			else
				count = parts[0].to_i
				unit = parts[1].gsub(/\s+/, '_').downcase.to_sym
			end
			
			unless VALID_UNITS.include? unit
				raise ArgumentError.new("Invalid unit specified #{unit}!")
			end
			
			if count == 0
				raise ArgumentError.new("Count must be non-zero!")
			end
			
			return self.new(count, unit)
		end
		
		def initialize(count = 1, unit = :days)
			@count = count
			@unit = unit
		end
		
		def to_s
			"#{@count} #{@unit}"
		end
		
		def to_formatted_s
			if @count == 1
				@unit.to_s.gsub(/s$/, '')
			else
				to_s
			end
		end
		
		def advance(date, multiple = 1)
			total = multiple * @count
			
			if unit == :days
				date + total
			elsif unit == :weeks
				date + (total * 7)
			elsif unit == :months
				date >> total
			elsif unit == :years
				date >> (total * 12)
			end
		end
		
		attr :unit
		attr :count
	end
end
