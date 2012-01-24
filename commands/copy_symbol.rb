require 'ruble'

command t(:copy_symbol) do |cmd|
  cmd.key_binding = 'M4+M3+C'
  cmd.scope = 'source.python'
  cmd.output = :discard
  cmd.input = :document
  cmd.invoke =<<-EOF
#!/usr/bin/env python
import sys
import re
import os

re_symbol = re.compile(r"^(\s*)(?:class|def)\s+([a-zA-Z_][a-zA-Z_0-9]*)\s*[\:\(]")
tm_line_num = int(os.environ['TM_LINE_NUMBER'])
line_num = 0

symbols = []
for line in sys.stdin:
    line_num += 1
    m = re_symbol.search(line)
    if m:
        ws, name = m.groups()
        ws_len = len(ws.expandtabs())
        while symbols and symbols[-1][0] >= ws_len:
            symbols.pop()
        symbols.append((ws_len, name))
    if line_num == tm_line_num:
        break

symbol = '.'.join([t[1] for t in symbols])
p = os.popen("/usr/bin/pbcopy", "w")
p.write(symbol)
p.close()


EOF
end
