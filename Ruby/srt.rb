def loopThrough(directory)
  Dir.foreach(directory) do |filename|
    next if filename == '.' or filename == '..'
    # file is a directory
    absolute = File.join(directory, filename)
    if File.directory?(absolute)
      procdir(absolute)
      # renameSrt(absolute)
    end
  end
end

def procdir(dir)
  all = Dir[ File.join(dir, '**', '*') ].reject do |f| 
    File.directory?(f) or (File.extname(f) != '.srt' and File.extname(f) != '.mkv') 
  end
  puts all
end

def renameSrt(directory)
  srts = []
  videos = []
  Dir.foreach(directory) do |filename|
    next if filename == '.' or filename == '..'
    if File.extname(filename) == '.srt'
      srts.append(filename)
      puts filename
    end
  end
end

def main()
  if ARGV.empty?
    puts "Usage: #{ __FILE__ } <path>"
    exit(2)
  end
  directory = ARGV[0]
  puts directory

  loopThrough(directory)
end



main() # calls main
