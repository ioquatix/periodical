# Periodical

Periodical is a simple framework for working with durations and periods. A duration measures a range of time bounded by a `from` date and `to` date. A period is a relative unit of time such as `4 weeks`.

[![Development Status](https://github.com/ioquatix/periodical/workflows/Development/badge.svg)](https://github.com/ioquatix/periodical/actions?workflow=Development)

## Motivation

The original idea for this library came from a [Python script which performed backup rotation](http://www.scottlu.com/Content/Snapfilter.html) from 2009. In particular, I thought it had a novel way to retain backups according to a given policy (e.g. one backup every year for 10 years, one backup every month for 12 months, one backup every week for 8 weeks, one backup every day for 30 days). This is done by constructing a special slot based hash structure with keys based on the date being stored. This functionality is used by [LSync](https://github.com/ioquatix/LSync) for performing backup rotation (i.e. deleting old backups).

In addition, I had a need to implement periodical billing in [Financier](https://github.com/ioquatix/financier). Not only can this gem advance a date by a given period, it can compute the number of periods between two dates. This is useful for invoicing, say, once every 6 months for a weekly or monthly service.

## Installation

Add this line to your application's Gemfile:

``` shell
$ bundle add periodical
```

## Usage

The main use case for this framework involves periodic billing or accounting (e.g. calculating fortnightly rental payments).

``` ruby
duration = Periodical::Duration.new(Date.parse("2010-01-01"), Date.parse("2010-02-01"))
period = Periodical::Period.new(2, :weeks)

# How many periods in the duration?
count = duration / period

# Calculate the date which is 2 * (2 weeks)
next = period.advance(duration.from, 2)
```

## Contributing

1.  Fork it
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create new Pull Request

## License

Released under the MIT license.

Copyright, 2010, 2014, 2016, by [Samuel G. D. Williams](http://www.codeotaku.com/samuel-williams).

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
