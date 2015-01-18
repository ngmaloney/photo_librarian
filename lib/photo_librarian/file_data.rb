require 'exifr'
require 'digest'
require 'date'
require 'pry'

module PhotoLibrarian
  class FileData
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def date
      Date.parse("#{exif_file.date_time || File.mtime(file)}")
    end

    def hash
      @hash ||= Digest::MD5.file(file).hexdigest
    end

    def jpg?
      if exif_file
        true
      else
        false
      end
    end

    private

    def exif_file
      begin
        @exif_file ||= EXIFR::JPEG.new(file)
      rescue => e
        #TODO better handling, logging and such
        @exif_file = false
      end
    end
  end
end
