# Periodical

Periodical is a simple framework for working with durations and periods. A duration measures a range of time bounded by a `from` date and `to` date. A period is a relative unit of time such as `4 weeks`.

## Installation

Add this line to your application's Gemfile:

    gem 'periodical'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install periodical

## Usage

The main use case for this framework involves periodic billing or accounting (e.g. calculating fortnightly rental payments).

	duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2010-02-01"))
	period = Periodical::Period.new(2, :weeks)
	
	# How many periods in the duration?
	count = duration / period
	
	# Calculate the date which is 2 * (2 weeks)
	next = period.advance(duration.from, 2)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT license.

Copyright, 2010, 2014, by [Samuel G. D. Williams](http://www.codeotaku.com/samuel-williams).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
