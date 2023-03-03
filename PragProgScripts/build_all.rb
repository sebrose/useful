#!/usr/bin/env ruby

TEXTTEST="/Applications/texttest-3.26/source/bin/texttest"

def extract comment
  treeish = ":/^===#{comment}==="
  STDOUT.puts "Checking out #{treeish}"
  `git checkout #{treeish}`  or raise "Error checking out"  
  
  `#{TEXTTEST} -b build_all -d #{}/texttest`
end

def build_all repo
  count = 1
  
  STDOUT.puts "chdir #{repo}"
  Dir.chdir src

  STDOUT.puts "cleaning"
  `mvn clean` if File.exists("pom.xml")
  `rm -rf out`
  `rm -rf messages`
  `rm balance`

  # Record original branch
  branch_name=`git symbolic-ref HEAD 2>/dev/null`
  branch_name=branch_name[11..-1]
  STDOUT.puts "On branch: #{branch_name}"
  
  STDOUT.puts "getting git log"
  logs = `git log --oneline --grep='^==='`.split("\n")
  
  logs.map! { |log| log.match(/^[a-zA-Z0-9]* ===([a-zA-Z0-9_\/]*)===/).captures[0] }
  logs.uniq!
  logs.reverse!
  logs.each { |log|
    STDOUT.puts "looping over log"
    build log
    
    count = count - 1
    if count == 0
      break
    end
  }  

  # Checkout original branch
  `git checkout #{branch_name}`
 
  Dir.chdir ".."
  STDOUT.puts "Done"
end

if ARGV.length == 1
  build_all ARGV[0]
else
  STDOUT.puts <<-EOF
Usage:
    build_all <GIT REPO LOCATION>
EOF
end
