require 'ruble'

command 'Run Script (Terminal)' do |cmd|
  cmd.key_binding = 'M1+M2+R'
  cmd.scope = 'source.python'
  cmd.output = :discard
  cmd.input = :document
  cmd.invoke =<<-EOF
#!/bin/bash
[[ -z "$TM_FILEPATH" ]] && TM_TMPFILE=$(mktemp -t pythonInTerm)
: "${TM_FILEPATH:=$TM_TMPFILE}"; cat >"$TM_FILEPATH"

TPY=${TM_PYTHON:-pythonw}

esc () {
STR="$1" ruby <<"RUBY"
   str = ENV['STR']
   str = str.gsub(/'/, "'\\\\''")
   str = str.gsub(/[\\"]/, '\\\\\\0')
   print "'\#{str}'"
RUBY
}

osascript <<- APPLESCRIPT
	tell app "Terminal"
	    launch
	    activate
	    do script "clear; cd $(esc "${TM_DIRECTORY}"); $(esc "${TPY}") $(esc "${TM_FILEPATH}"); rm -f $(esc "${TM_TMPFILE}")"
	    set position of first window to { 100, 100 }
	end tell
APPLESCRIPT


EOF
end
