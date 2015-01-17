require 'find'
require 'photo_librarian/file_data'

module PhotoLibrarian
  class Importer
    attr_reader :source, :destination

    def initialize(source, destination)
      @source = File.expand_path(source)
      @destination = File.expand_path(destination)
    end

    def import!
      Find.find(source).each do |node|
        next unless File.file?(node)

        file_data = FileData.new(node)

        if file_data && file_data.jpg?
          file_dir = file_dest(file_data)
          file_name = file_data.hash + ".jpg"
          FileUtils.mkdir_p(file_dir)
          FileUtils.cp(node, File.join(file_dir, file_name))
        end
      end
    end

    def file_dest(file)
      rel_path = file.date.strftime("%Y %m").split(" ")
      File.join(destination, rel_path)
    end
  end
end
