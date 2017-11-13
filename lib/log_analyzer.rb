module GitLogStats
  # process a data comming from `git log -m --stat` and generates statistics
  class LogAnalyzer
    require 'repository'
    require 'report'
    require 'json'

    def initialize(file_path)
      @report = Report.new
      @repository = Repository.new file_path
    end

    def process_log_file
      process_commits
      print @report.to_s
    end

    def process_commits
      @repository.commits.each do |commit|

        process_date commit
        process_techs commit
      end
    end

    def process_techs(commit)
      commit.files.each do |file|
        next unless !File.extname(file[:path]).empty? && file[:type] == :text

        tech = File.extname(file[:path]).gsub(/^\./, '').upcase
        @report.user_report(commit.author).append_tech_usage(
          tech,
          file[:additions] + file[:deletions]
        )
      end
    end

    def process_date(commit)
      user_report = @report.user_report(commit.author)

      user_report.first_commit = commit.date if
        !user_report.first_commit ||
        user_report.first_commit > commit.date

      user_report.last_commit = commit.date if
        !user_report.last_commit ||
        user_report.last_commit < commit.date
    end
  end
end
