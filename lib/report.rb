module GitLogStats
  # commit unit
  class Report
    require 'user_report'

    def initialize
      @users_reports = {}
    end

    def user_report(ident)
      @users_reports[ident] ||= UserReport.new ident
    end

    def to_s
      content = ''
      @users_reports.each do |ident, user_report|
        content << "Report for #{ident}:\n"
        content << user_report.to_s
      end
      content
    end
  end
end
