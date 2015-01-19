module PhotoLibrarian
  class Spinner
    def self.show(fps=10, title="Generating file list ")
      chars = %w[| / - \\]
      delay = 1.0/fps
      iter = 0
      spinner = Thread.new do
        print title
        while iter do  # Keep spinning until told otherwise
          print chars[(iter+=1) % chars.length]
          sleep delay
          print "\b"
        end
      end
      yield.tap do       # After yielding to the block, save the return value
        iter = false   # Tell the thread to exit, cleaning up after itself…
        spinner.join   # …and wait for it to do so.
      end                # Use the block's return value as the method's
    end
  end
end
