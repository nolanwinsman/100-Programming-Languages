require 'pathname'


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
  subs = []
  videos = []
  all = Dir[ File.join(dir, '**', '*') ].reject do |f| 
    File.directory?(f) or (File.extname(f) != '.srt' and File.extname(f) != '.mp4') 
  end

  all.each { |elem|
    if File.extname(elem) == '.srt'
      subs.append(elem)
    end
    if File.extname(elem) == '.mp4'
      videos.append(elem)
    end
  }
  if subs.length() == 1 and videos.length() == 1
    copyFileName(videos[0], subs[0]) 
  end
end

def copyFileName(base, toCopy)
  toCopyParent = Pathname.new(toCopy).parent
  baseChild = File.basename(base, File.extname(base))
  newName = "%s.en%s" % [baseChild, File.extname(toCopy)]
  puts newName
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
