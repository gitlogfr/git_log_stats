module GitLogStats
  # commit unit
  class Commit
    require 'time'
    attr_reader :files, :date, :comment, :hash
    attr_accessor :author

    def initialize
      @state = :processing_headers
      @files = []
      @comment = ''
    end

    def consume_line(line)
      line.gsub!(/\n$/, '')
      @state = :processing_comment if /^ {4}/ =~ line && @state == :processing_headers
      @state = :processing_files if /^ [^ ]/ =~ line && @state == :processing_comment
      @state = :processing_footer if / [0-9]+ files? changed(, [0-9]+ insertions\(\+\))?(, [0-9]+ deletions\(-\))?/ =~ line && @state == :processing_files
      @state = :processing_done if line.empty? && @state == :processing_footer

      case @state
      when :processing_headers
        process_header line
      when :processing_comment
        process_comment line
      when :processing_files
        process_file line
      end
    end

    def closed?
      @state == :processing_done
    end

    def debug
      p @comment
    end

    private

    def process_file(line)
      file = {}
      line.gsub!(/\{.* => (.*)\}/, '\1')

      groups = /^(.+) +\| +(?:(?:[0-9]+(?: +|$)(\+*)(-*))|(?:(Bin)(?: ([0-9]+) -> ([0-9]+) bytes)?))$/.match(line)
      file[:path] = groups[1].strip
      if groups[4] == 'Bin'
        file[:type] = :bin
        file[:delta] = groups[6].to_i - groups[5].to_i
      else
        file[:type] = :text
        file[:additions] = groups[1].length
        file[:deletions] = groups[2].length
      end

      @files << file
    end

    def process_comment(line)
      @comment << "\n"
      @comment << line.strip
      @comment.strip!
    end

    def process_header(line)
      case header_type(line)
      when :commit
        process_commit_header line
      when :author
        process_author_header line
      when :date
        process_date_header line
      end
    rescue => e
      print "Failed on line '#{line}'"
      raise e
    end

    def process_commit_header(line)
      groups = /^commit (.{40})(?: \(from (.{40})\))?$/.match(line)
      @hash = groups[1]
      @merge_hash = groups[2]
    end

    def process_author_header(line)
      groups = /^Author: (.*)$/.match(line)
      @author = groups[1]
    end

    def process_date_header(line)

      groups = /^Date: +(.*)$/.match(line)

      @date = Time.at(groups[1].to_i)
    end

    def header_type(line)
      return :commit if /^commit / =~ line
      return :author if /^Author: / =~ line
      return :date if /^Date: / =~ line
    end
  end
end
