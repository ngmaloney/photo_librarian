require 'photo_librarian/importer'

module PhotoLibrarian
  def self.import!(args)
    source, dest = *args
    puts "Source and destination are required" unless source && dest
    PhotoLibrarian.import(source, dest)
  end

  def self.import(source, destination)
    importer = PhotoLibrarian::Importer.new(source, destination)
    importer.import!
  end
end
