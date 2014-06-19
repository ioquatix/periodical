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

require 'date'

module Periodical
	class Duration
		def initialize(from, to)
			@from = from
			@to = to
		end
		
		attr :from
		attr :to
		
		def days
			@to - @from
		end
		
		def weeks
			days / 7
		end
		
		def whole_months
			(@to.year * 12 + @to.month) - (@from.year * 12 + @from.month)
		end
		
		def months
			whole = self.whole_months
			
			partial_start = @from >> whole
			partial_end = @from >> whole + 1
			
			return whole + (@to - partial_start) / (partial_end - partial_start)
		end
		
		def whole_years
			@to.year - @from.year
		end
		
		def years
			whole = self.whole_years
			
			partial_start = @from >> (whole * 12)
			partial_end = @from >> ((whole + 1) * 12)
			
			return whole + (@to - partial_start) / (partial_end - partial_start)
		end
		
		# Calculate the number of periods between from and to
		def / period
			self.send(period.unit) / period.count
		end
	end
end
