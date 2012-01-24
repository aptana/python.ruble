require 'ruble'

command 'Execute Line/Selection as Python' do |cmd|
  cmd.key_binding = 'M4+M2+E'
  cmd.scope = 'source.python'
  cmd.output = :insert_as_text
  cmd.input = :selection, :line
  cmd.invoke =<<-EOF
#!/usr/bin/env python

import os
from sys import stdout, stdin, exit
from traceback import format_stack

py = stdin.read()

if 'TM_SELECTED_SCOPE' in os.environ:
    stdout.write(" ")
else:
    stdout.write("\n")

try:
    scope = {}
    result = eval(py, globals(), scope)
except:
    exc = format_stack()
    stdout.write(exc)
    exit(206) # exiting with this code show's output in a tooltip 
else:
    stdout.write(repr(result))


EOF
end
