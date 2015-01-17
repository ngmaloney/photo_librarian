require 'minitest/spec'
require 'minitest/autorun'
require 'fileutils'
require 'spec_helper'

describe PhotoLibrarian do
  let(:base_path) { "/tmp/photo_librarian" }
  let(:source_path) { base_path + "/source" }
  let(:destination_path) { base_path + "/dest" }

  before do
    setup_fixtures
  end

  after do
    breakdown_fixtures
  end

  describe "::import!" do
    it "copies the photos to their expected locations" do
      PhotoLibrarian.import(source_path, destination_path, false)
      File.exists?(destination_path + "/2010/05/3c5ddc299f1523132137d3b0b7139b33.jpg").must_equal true
      File.exists?(destination_path + "/2015/01/100dec19efcf725f983e6d77e5f2bc6c.jpg").must_equal true
    end
  end

  def setup_fixtures
    FileUtils.mkdir_p(source_path)
    FileUtils.mkdir_p(destination_path)
    FileUtils.cp_r("#{File.expand_path(".")}/spec/fixtures/photos/", source_path)
  end

  def breakdown_fixtures
    FileUtils.rm_r(base_path)
  end
end
