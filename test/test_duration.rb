
require 'helper'

require 'periodical'

class DurationTest < Test::Unit::TestCase
	def setup
	end
	
	def test_duration
		duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2010-02-01"))
		assert_equal 31, duration.days
		assert_equal Rational(31, 7), duration.weeks
		assert_equal 1, duration.months
		assert_equal Rational(31, 365), duration.years
		
		assert_equal 1, duration.whole_months
		assert_equal 0, duration.whole_years
	end
	
	def test_weekly_period
		duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2010-02-01"))
		period = Periodical::Period.new(2, :weeks)
		
		assert_equal Rational(31, 14), duration / period
	end
	
	def test_monthly_period
		duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2011-03-01"))
		period = Periodical::Period.new(2, :months)
		
		assert_equal Rational(14, 2), duration / period
	end
end
