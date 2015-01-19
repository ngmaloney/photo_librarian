require 'photo_librarian/file_data'
require 'photo_librarian/spinner'
require 'find'
require 'ruby-progressbar'
require 'fileutils'

module PhotoLibrarian
  class Importer
    attr_reader :source, :destination, :file_list, :show_progress

    def initialize(source, destination, show_progress = true)
      @source = File.expand_path(source)
      @destination = File.expand_path(destination)
      @show_progress = show_progress
      @file_list = []
    end

    def import!
      if show_progress
        PhotoLibrarian::Spinner.show { build_file_list }
      else
        build_file_list
      end
      import_files
    end

    def build_file_list
      Find.find(source).each do |file|
        next unless File.file?(file)
        file_data = FileData.new(file)
        if file_data && file_data.jpg?
          @file_list << file
        end
      end
    end

    def import_files
      file_list.each do |f|
        file_data = FileData.new(f)
        import_file(file_data)
        progress_bar.increment if show_progress
      end
    end

    def import_file(file_data)
      begin
        file_dir = file_dest(file_data)
        file_name = file_data.hash + ".jpg"
        file_path = File.join(file_dir, file_name)
        FileUtils.mkdir_p(file_dir)
        FileUtils.cp(file_data.file, file_path, preserve: true) unless File.exists?(file_path)
      rescue => e
        #TODO Log this
      end
    end


    def file_dest(file)
      rel_path = file.date.strftime("%Y %m").split(" ")
      File.join(destination, rel_path)
    end

    def progress_bar
      @progress_bar ||= ProgressBar.create(title: "Copying photos", total: file_list.length)
    end
  end
end
