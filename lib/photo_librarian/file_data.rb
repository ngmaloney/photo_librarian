require 'exifr'
require 'digest'
require 'pry'

module PhotoLibrarian
  class FileData
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def date
      exif_file.date_time || File.mtime(file)
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
      rescue EXIFR::MalformedJPEG
        @exif_file = false
      end
    end
  end
end