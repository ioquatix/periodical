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

module Periodical::PeriodSpec
	describe Periodical::Period do
		it "should advance by 1 month" do
			duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2011-01-01"))
			
			period = Periodical::Period.new(1, :months)
			
			expect(period.advance(duration.from, 12)).to be == duration.to
		end
		
		it "should parse a singular period" do
			period = Periodical::Period.parse("years")
			
			expect(period.count).to be == 1
			expect(period.unit).to be == :years
		end
		
		it "should parse a multiple count period" do
			period = Periodical::Period.parse("5 days")
			
			expect(period.count).to be == 5
			expect(period.unit).to be == :days
		end
		
		it "can load nil" do
			expect(Periodical::Period.load(nil)).to be == nil
			expect(Periodical::Period.load("")).to be == nil
		end
		
		it "can dump nil" do
			expect(Periodical::Period.dump(nil)).to be == nil
		end
		
		it "can load string" do
			expect(Periodical::Period.load("5 weeks")).to be == Periodical::Period.new(5, :weeks)
		end
		
		it "can dump nil" do
			expect(Periodical::Period.dump(Periodical::Period.new(5, :weeks))).to be == "5 weeks"
		end
	end
end
