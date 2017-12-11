require 'git'
module GitLogStats
  # Abstraction of a repository
  class Repo

    def initialize(repository_path)
      @git_repo = Git.open(repository_path)
    end

    def debug
      p @git_repo.log
    end


    def init
      ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
    end
  end
end
