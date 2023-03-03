#!/usr/bin/env ruby

TEXTTEST="/Applications/texttest-3.26/source/bin/texttest"

def setup comment
  treeish = ":/^===#{comment}==="
  STDOUT.puts "Branching #{treeish} as 'work'"
  `git branch -D work`
  `git branch work #{treeish}`  or raise "Error checking out"
  `git checkout work`
  
  pwd = `pwd`.chomp!
  STDOUT.puts "Invoking TEXTTEST at #{pwd}/texttest"
  `#{TEXTTEST} -d #{pwd}/texttest`
end

def setup_all repo
  count = 1
  
  STDOUT.puts "chdir #{repo}"
  Dir.chdir repo

  STDOUT.puts "getting git log"
  logs = `git log --oneline --grep='^==='`.split("\n")
  
  logs.map! { |log| log.match(/^[a-zA-Z0-9]* ===([a-zA-Z0-9_\/]*)===/).captures[0] }
  logs.uniq!
  logs.reverse!
  logs.each { |log|
    STDOUT.puts "looping over log"
    setup log
    
    count = count - 1
    if count == 0
      break
    end
  }  

  Dir.chdir ".."
  STDOUT.puts "Done"
end

if ARGV.length == 1
  setup_all ARGV[0]
else
  STDOUT.puts <<-EOF
Usage:
    build_all <GIT REPO LOCATION>
EOF
end
