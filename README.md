# GitLogStats

Get to know the company you are working for from their git log

## Installation

```ruby
gem 'git_log_stats'
```

## Usage

Generate an input git log file using :

    $ git log -m --stat=90000 --date=iso > file.txt

then generate a report with:

    $ gitlogstats --file=data.txt

## Development

This is an early version, current reports are not considered as valid.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/git_log_stats.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
