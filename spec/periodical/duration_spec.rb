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

require 'periodical'

module Periodical::DurationSpec
	describe Periodical::Duration do
		it "should measure durations correctly" do
			duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2010-02-01"))
			expect(duration.days).to be == 31
			expect(duration.weeks).to be == Rational(31, 7)
			expect(duration.months).to be == 1
			expect(duration.years).to be == Rational(31, 365)
		
			expect(duration.whole_months).to be == 1
			expect(duration.whole_years).to be == 0
		end
	
		it "should compute the correct number of weeks" do
			duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2010-02-01"))
			period = Periodical::Period.new(2, :weeks)
		
			expect(duration / period).to be == Rational(31, 14)
		end
		
		it "should compute the correct number of months" do
			duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2011-03-01"))
			period = Periodical::Period.new(2, :months)
		
			expect(duration / period).to be == Rational(14, 2)
		end
	end
end
