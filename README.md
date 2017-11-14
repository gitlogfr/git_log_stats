# GitLogStats ![](https://img.shields.io/gem/dt/git_log_stats.svg)

**⚠️ beta version**  

## description

git_log_stats is a gem which computes statistics and various informations about a company from their `git log`.  
It's goal is to provide you use with useful information when starting a new gig to understand how your working habits will look like in the following months.  

The current version includes:
- the breakdown of technologies in percentage each developer is working on
- The date they joined, and left the company

Jump to the [Roadmap](#Roadmap) section for new upcoming information.


## Installation

```ruby
gem install 'git_log_stats'
```

## Usage

Generate a git log dump using :

    $ git log -m --stat=90000 --date=unix > ~/log.txt

then generate a report with:

    $ gitlogstats --file=/Users/simon/log.txt

Multiple dumps can be merged with a new line separator.  
For instance using something like :

    $ for f in git_log_*.txt; do (cat "${f}"; echo) >> finalfile.txt; done

## Roadmap

### 0.1.0
 - Add tests
 - code cleaning

### 0.2.0
 - Add turnover statistics
 - Add statistics about working habits
     - Do they work on week-ends ?
     - When does the day starts ?
     - How often are they "in the rush" ?

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gitlogfr/git_log_stats.git.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
