require 'ruble'

command 'Debug Script in Terminal' do |cmd|
  cmd.key_binding = 'M1+M2+D'
  cmd.scope = 'source.python'
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke =<<-EOF
# start up Python in debug mode using either Terminal.app or iTerm.app
# according to the user's value for TM_TERM_PROG
# Default to Terminal.app since that is standard.
TP=${TM_TERM_PROG:=Terminal}
TPY=${TM_PYTHON:=python}

if [ "$TP" == iTerm ]; then
    osascript <<END
        tell application "iTerm"
            activate
            set myterm to (the first terminal)
            tell myterm            
                set mysession to (make new session at the end of sessions)
                tell mysession
                    exec command "/bin/bash -c \"$TPY -m pdb '$TM_FILEPATH' \" " 
                end tell
            end tell
        end tell
END
else
    osascript  <<END2
        tell application "Terminal"
            activate
            do script with command "$TPY -m pdb '$TM_FILEPATH'"
        end tell
END2
fi

EOF
end
