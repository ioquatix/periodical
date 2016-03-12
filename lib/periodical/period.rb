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
	Period = Struct.new(:count, :unit) do
		VALID_UNITS = [:days, :weeks, :months, :years].freeze
		
		# Plural is preferred, as in "1 or more days".
		def initialize(count = 1, unit = :days)
			super(count, unit)
		end
		
		def to_s
			if self.count != 1
				"#{self.count} #{self.unit}"
			else
				self.unit.to_s
			end
		end
		
		def advance(date, multiple = 1)
			self.send("advance_#{unit}", date, multiple * self.count)
		end
		
		private
		
		def advance_days(date, count)
			date + count
		end
		
		def advance_weeks(date, count)
			date + (7 * count)
		end
		
		def advance_months(date, count)
			date >> count
		end
		
		def advance_years(date, count)
			date >> (12 * count)
		end
		
		class << self
			# Accepts strings in the format of "2 weeks" or "weeks"
			def parse(string)
				parts = string.split(/\s+/, 2)
				
				if parts.size == 1
					count = 1
					unit = parts[0]
				else
					count, unit = parts
				end
				
				self.new(count.to_i, unit.to_sym)
			end
			
			def load(string)
				if string
					string = string.strip
					
					parse(string) unless string.empty?
				end
			end
			
			def dump(period)
				period.to_s if period
			end
		end
	end
end
