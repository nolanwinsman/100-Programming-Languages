require 'pathname'

# array of video file extensions
VIDEO_EXTENSIONS = ['.mp4','.mkv']
# array of subtitle file extensions
SUB_EXTENSIONS = ['.srt']


# loops through all files in the directory given as an argument
# if the file looped through is another directory, call findFiles() on that directory
#
# Params:
# +directory+:: the directory being looped through
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

# Finds the number of video files and subtitle files in a directory
# if there is only one video files and one subtitle file, it calls copyFileName on those two files
#
# Params:
# +dir+:: the directory this function is looking at
def findFiles(dir)
  subs = []
  videos = []
  all = Dir[ File.join(dir, '**', '*') ].reject do |f| 
    File.directory?(f) or (not SUB_EXTENSIONS.include? File.extname(f) and not VIDEO_EXTENSIONS.include? File.extname(f)) 
  end

  all.each { |elem|
    if SUB_EXTENSIONS.include? File.extname(elem)
      subs.append(elem)
    end
    if VIDEO_EXTENSIONS.include? File.extname(elem)
      videos.append(elem)
    end
  }
  if subs.length() == 1 and videos.length() == 1
    copyFileName(videos[0], subs[0]) 
  end
end

# Takes in two parameters and copies the filename of one to the other.
# Adds .en to toCopy since it should be an english subtitle file
#
# Params:
# +base+:: the filename that is being copied
# +toCopy+:: the file that is copying the filename from param base
def copyFileName(base, toCopy)
  toCopyParent = Pathname.new(toCopy).parent
  baseChild = File.basename(base, File.extname(base))
  newName = "%s.en%s" % [baseChild, File.extname(toCopy)] # adds .en for english subtitles
  puts "Renaming %s to %s" % [toCopy, newName]
  completeName = File.join(toCopyParent, newName)
  File.rename(toCopy, completeName)
end

# main method
# checks that there is at least one argument
# if an argument is not provided, exits the program
def main()
  if ARGV.empty?
    puts "Usage: #{ __FILE__ } <path>"
    exit(2)
  end
  directory = ARGV[0]
  loopThrough(directory)
end



main() # calls main
