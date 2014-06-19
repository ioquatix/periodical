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

require 'periodical/filter'

module Periodical::PeriodSpec
	describe Periodical::Filter do
		it "should select at most 3 days worth of data" do
			dates = [
				Date.parse("2010-01-01"),
				Date.parse("2010-01-02"),
				Date.parse("2010-01-03"),
				Date.parse("2010-01-04"),
				Date.parse("2010-01-05"),
				Date.parse("2010-01-06"),
			]
			
			policy = Periodical::Filter::Policy.new
			policy << Periodical::Filter::Daily.new(3)
			
			selected, rejected = policy.filter(dates)
			expect(selected.count).to be 3
			expect(rejected.count).to be 3
			
			# Keep oldest is the default policy
			expect(selected).to be_include(dates[0])
		end
		
		it "should keep youngest" do
			dates = [
				Date.parse("2010-01-01"),
				Date.parse("2010-01-02"),
			]
			
			policy = Periodical::Filter::Policy.new
			policy << Periodical::Filter::Monthly.new(1)
			
			selected, rejected = policy.filter(dates, :keep => :youngest)
			expect(selected.count).to be 1
			expect(rejected.count).to be 1
			
			# Keep oldest is the default policy
			expect(selected).to be_include(dates[1])
		end
	end
end
