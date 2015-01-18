require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'fileutils'
require 'time'

describe PhotoLibrarian do
  let(:fixtures_path) {"#{File.expand_path(".")}/spec/fixtures/photos/"}
  let(:valid_image) { fixtures_path + "1.jpg" }
  let(:file_data) { PhotoLibrarian::FileData.new(valid_image) }

  describe "jpg?" do
    let(:invalid_image) { fixtures_path + "1.txt" }

    it "detects a valid jpg file" do
      file_data.jpg?.must_equal true
    end

    it "detects a text file" do
      PhotoLibrarian::FileData.new(invalid_image).jpg?.must_equal false
    end
  end

  describe "hash" do
    it "returns a hash" do
      file_data.hash.must_equal "3c5ddc299f1523132137d3b0b7139b33"
    end
  end

  describe "date" do
    describe "with exif date" do
      it "returns a date" do
        file_data.date.must_equal Date.parse("2010-05-04 10:44:57 -0400")
      end
    end

    describe "with file data" do

      let(:valid_image) { fixtures_path + "2.jpg" }

      it "returns a date" do
        file_data.date.must_equal Date.parse("2011-01-27 10:54:26 -0500")
      end
    end
  end
end
