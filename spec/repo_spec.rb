require 'spec_helper'
require 'sample_repository'
require 'repo'
require 'spec_helper'

describe 'Repo' do
  SampleRepository.gen_dummy_repo do |repo_path|
    repo = GitLogStats::Repo.new repo_path
  end
end
