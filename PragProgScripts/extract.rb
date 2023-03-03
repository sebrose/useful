#!/usr/bin/env ruby

def extract comment, dest
  treeish = ":/^===#{comment}==="
  STDOUT.puts "Checking out #{treeish}"
  `git checkout #{treeish}`  or raise "Error checking out"
  
  
  path = "../#{dest}/#{comment}"
  STDOUT.puts "Copying to #{path}"
  `ditto . #{path}`
end

def extract_tags src, dest, count
  STDOUT.puts "chdir #{src}"
  Dir.chdir src

  STDOUT.puts "cleaning"
  `mvn clean`
  `rm -rf out`
  `rm -rf messages`
  `rm balance`

  branch_name=`git symbolic-ref HEAD 2>/dev/null`
  branch_name=branch_name[11..-1]
  STDOUT.puts "On branch: #{branch_name}"
  
  STDOUT.puts "getting git log"
  logs = `git log --oneline --grep='^==='`.split("\n")
  
  logs.map! { |log| log.match(/^[a-zA-Z0-9]* ===([-a-zA-Z0-9_\/]*)===/).captures[0] }
  logs.uniq!
  logs.each { |log|
    STDOUT.puts "looping over log"
    extract log, dest
    
    count = count - 1
    if count == 0
      break
    end
  }  

  `git checkout #{branch_name}`
 
  Dir.chdir ".."
  STDOUT.puts "Done"
end

if ARGV.length == 2
  extract_tags ARGV[0], ARGV[1], -1
elsif ARGV.length == 3
  extract_tags ARGV[0], ARGV[1], ARGV[2].to_i
else
  STDOUT.puts <<-EOF
Usage:
    extract <GIT REPO LOCATION> <ROOT_PATH_OF_EXTRACT>
EOF
end
