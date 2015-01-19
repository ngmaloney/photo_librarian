# PhotoLibrarian

I needed a simple way to organize a decade worth of photos that were spread across numerous directories. The files had inconsistent naming conventions and were duplicated in several of the folders. Ideally, I wanted them organized by month and year and have duplicates removed. I found a few tools that almost did this but not exactly. I wrote PhotoLibrarian as a quick hack to solve the problem.

Photo librarian is a simple command line utility that organizes photos. It copies photos into a destination directory organized by year then month. By default, the command will use the photos EXIF data for determining date, if there isn't an EXIF date present it will default to the file's creation date. Files will be renamed according to their MD5 hash value. Duplicate files are not copied. The source image directory is not altered.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'photo_librarian'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install photo_librarian

## Usage

librarian /path/to/images  /path/to/destination

## Contributing

1. Fork it ( https://github.com/[my-github-username]/photo_librarian/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
