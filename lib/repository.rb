module GitLogStats
  # Abstraction of a repository
  class Repository
    require 'commit'
    attr_reader :commits

    def initialize(file_path)
      @log_file_path = file_path
      @commits = []
      @deduplicated_authors = {}
      generate_commits
      setup_configuration
      rewrite_commits_authors
      p @commits.length
    end

    def setup_configuration
      data = File.read('./duplicated_authors.json')
      @deduplicated_authors = JSON.parse(data)
    rescue
      print "No readable configuration file found\n"
      interactive_dedups
    end

    def interactive_dedups
      aborted = false
      processed_author = []
      raw_authors = raw_uniq_authors
      raw_authors.each do |author|
        next if processed_author.include? author
        raw_authors.each_with_index do |possible_dup_author, index|
          next if possible_dup_author == author
          next if processed_author.include? possible_dup_author

          print "#{index.to_s.ljust(4)} - #{possible_dup_author.ljust(80)}\n"
        end
        print "\n-------------\n"
        print "Duplicates for #{author} (comma separated list of indexes or 's' to finish now):\n"
        input = gets.strip

        aborted = input == 's'

        break if aborted

        raise 'Invalid index' unless input =~ /^[0-9,]*$/
        input.split(',').each do |index|
          index = index.to_i
          @deduplicated_authors[author] ||= []
          @deduplicated_authors[author] << raw_authors[index]
          processed_author << raw_authors[index]
        end
        processed_author << author
      end

      begin
        config_file = File.open('./duplicated_authors.json', 'w')
        config_file.write(@deduplicated_authors.to_json)
        print "Configuration saved in ./duplicated_authors.json\n"
      rescue
        print "Can't save configuration to ./duplicated_authors.json, skipped\n"
      ensure
        config_file.close unless config_file.nil?
      end
    end

    def rewrite_commits_authors
      replace_with = {}
      @deduplicated_authors.each do |base_author, replaced_authors|
        replaced_authors.each do |author|
          replace_with[author] = base_author
        end
      end

      @commits.each do |commit|
        commit.author = replace_with[commit.author] unless replace_with[commit.author].nil?
      end
    end

    def raw_uniq_authors
      @authors = @commits.map(&:author).uniq.reverse
    end

    def generate_commits
      begin
        open_file = File.open(@log_file_path)
      rescue
        raise 'Can\'t open this file'
      end

      commit = nil
      open_file.each do |line|
        commit = Commit.new if !commit || commit.closed?

        commit.consume_line line

        @commits << commit if commit.closed?
      end
    end
  end
end
