require 'photo_librarian/file_data'
require 'find'
require 'ruby-progressbar'

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
      Find.find(source).each do |file|
        next unless File.file?(file)

        file_data = FileData.new(file)

        if file_data && file_data.jpg?
          @file_list << file_data
        end
      end

      file_list.each do |f|
        import_file(f)
        progress_bar.increment if show_progress
      end
    end

    def import_file(file_data)
      file_dir = file_dest(file_data)
      file_name = file_data.hash + ".jpg"
      FileUtils.mkdir_p(file_dir)
      FileUtils.cp(file_data.file, File.join(file_dir, file_name))
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
