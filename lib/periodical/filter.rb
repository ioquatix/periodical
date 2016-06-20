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
require 'set'

module Periodical
	# A filter module for backup rotation like behaviour, e.g. keep every hour for 24 hours, every day for 30 days, etc.
	module Filter
		# Keep count sorted objects per period.
		class Period
			# Given times a and b, should we prefer a?
			ORDER = {
				# We want `a` if `a` < `b`, i.e. it's older.
				old: ->(a, b){a < b},
				
				# We want `a` if `a` > `b`, i.e. it's newer.
				new: ->(a, b){a > b}
			}
			
			# @param count the number of items we should retain.
			def initialize(count)
				@count = count
			end

			# @param order can be a key in ORDER or a lambda.
			# @param block is applied to the value and should typically return a Time instance.
			def filter(values, keep: :old, &block)
				slots = {}
				
				keep = ORDER.fetch(keep, keep)
				
				values.each do |value|
					time = block_given? ? yield(value) : value
					
					granular_key = key(time)
					
					# We filter out this value if the slot is already full and we prefer the existing value.
					if existing_value = slots[granular_key]
						existing_time = block_given? ? yield(existing_value) : existing_value
						next if keep.call(existing_time, time)
					end
					
					slots[granular_key] = value
				end
				
				sorted_values = slots.values.sort
				
				return sorted_values.first(@count)
			end

			def key(t)
				raise NotImplementedError
			end

			def mktime(year, month=1, day=1, hour=0, minute=0, second=0)
				return Time.new(year, month, day, hour, minute, second)
			end

			attr :count
		end

		class Hourly < Period
			def key(t)
				mktime(t.year, t.month, t.day, t.hour)
			end
		end

		class Daily < Period
			def key(t)
				mktime(t.year, t.month, t.day)
			end
		end

		class Weekly < Period
			def key(t)
				mktime(t.year, t.month, t.day) - (t.wday * 3600 * 24)
			end
		end

		class Monthly < Period
			def key(t)
				mktime(t.year, t.month)
			end
		end

		class Quarterly < Period
			def key(t)
				mktime(t.year, (t.month - 1) / 3 * 3 + 1)
			end
		end

		class Yearly < Period
			def key(t)
				mktime(t.year)
			end
		end

		class Policy
			def initialize
				@periods = {}
			end

			def <<(period)
				@periods[period.class] = period
			end

			def filter(values, **options, &block)
				filtered_values = Set.new
			
				@periods.values.each do |period|
					filtered_values += period.filter(values, **options, &block)
				end

				return filtered_values, (Set.new(values) - filtered_values)
			end

			attr :periods
		end
	end
end
