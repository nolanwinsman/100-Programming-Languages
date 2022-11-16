require 'pathname'

EXTENSIONS = ['.mp4','.mkv']

def loopThrough(directory)
  Dir.foreach(directory) do |filename|
    next if filename == '.' or filename == '..'
    absolute = File.join(directory, filename)
    # file is a directory
    if File.directory?(absolute)
      findFiles(absolute)
    end
  end
end

def findFiles(dir)
  subs = []
  videos = []
  all = Dir[ File.join(dir, '**', '*') ].reject do |f| 
    File.directory?(f) or EXTENSIONS.include? File.extname(f) 
  end

  all.each { |elem|
    if File.extname(elem) == '.srt'
      subs.append(elem)
    end
    if EXTENSIONS.include? File.extname(elem)
      puts elem
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
  puts "Renaming %s to %s" % [toCopy, newName]
  completeName = File.join(toCopyParent, newName)
  File.rename(toCopy, completeName)
end

def main()
  if ARGV.empty?
    puts "Usage: #{ __FILE__ } <path>"
    exit(2)
  end
  directory = ARGV[0]
  loopThrough(directory)
end



main() # calls main
