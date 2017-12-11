require 'tmpdir'
require 'bundler'
require 'git'

class SampleRepository

  def self.gen_dummy_repo
    Dir.mktmpdir do |directory|
      Git.clone('https://github.com/gitlogfr/git_log_stats.git', 'git_log_stats', :path => directory)
      yield(File.join(directory, 'git_log_stats'))
    end
  end


end
