module GitLogStats
  # commit unit
  class UserReport
    attr_accessor :first_commit, :last_commit, :ident

    def initialize(ident)
      @ident = ident
      @techs = {}
    end

    def append_tech_usage(tech, usage)
      @techs[tech] ||= 0
      @techs[tech] += usage
    end

    def to_s
      content = ''

      content << dates_to_s

      content << techs_to_s

      content
    end

    def dates_to_s
      content = ''
      content << "Started on #{first_commit.strftime('%D')}"
      content << ", left on #{last_commit.strftime('%D')}" if last_commit < Time.now - 20 * 24 * 60 * 60
      content << "\n"
      content
    end

    def techs_to_s
      content = ''

      @techs_percentage = @techs.clone

      cummulated_usage = @techs.inject(0) { |sum, usage| sum + usage[1] }
      @techs_percentage = @techs_percentage.map { |tech, usage| [tech, usage * 100 / cummulated_usage] }
      @techs_percentage = @techs_percentage.sort_by { |_key, value| -value }

      @techs_percentage.each do |tech, percentage|
        content << "#{tech.ljust(10)}: #{percentage} %\n" if percentage > 2
      end

      content
    end
  end
end
