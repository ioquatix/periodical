
require 'helper'

require 'periodical'

class PeriodTest < Test::Unit::TestCase
	def setup
	end
	
	def test_advance
		duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2011-01-01"))
		period = Periodical::Period.new(1, :months)
		assert_equal duration.to, period.advance(duration.from, 12)
	end
end
