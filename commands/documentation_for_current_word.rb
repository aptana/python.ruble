require 'ruble'

command t(:docs_for_word) do |cmd|
  cmd.key_binding = 'M4+H'
  cmd.scope = 'source.python'
  cmd.output = :show_as_html
  cmd.input = :document
  cmd.invoke =<<-EOF
# set up TM_FIRST_LINE containing the first line of the script.
read first_line
0<&- # close STDIN
export TM_FIRST_LINE="$first_line"

export PYTHONPATH="$TM_BUNDLE_SUPPORT/DocMate"
export PYTHONPATH="$TM_SUPPORT_PATH/lib:$PYTHONPATH"

/usr/bin/env python -S - <<PYTHON
# coding: UTF-8
import sys
from sys import exit

import tm_helpers
import webpreview
import docmate
import dialog

docmate.launch_pydoc_server()

# get current dotted word from the env
word = tm_helpers.current_word(r"[A-Za-z0-9_\.]*")

if not word:
    print "<meta http-equiv='Refresh' content='0;URL=%s'>" % docmate.pydoc_url()[0]
else:
    library_docs = docmate.library_docs(word)
    local_docs = docmate.local_docs(word)
    if library_docs:
        print webpreview.html_header("DocMate", "Python")
        print "<h3>Python Library Documentation</h3>\n"
        print "<ol style='list-style-type: lower-alpha;'>\n"
        for n, opt in enumerate(library_docs):
            desc, url = opt
            accesskey = chr(ord("a") + n)
            print '\t<li><a href="%s" accesskey="%s">%s</a></li>\n' % (url, accesskey, desc)
        print "</ol>\n"
    if local_docs and library_docs:
        print "<h3>Pydoc Documentation</h3>"
        print "<ol style='list-style-type: decimal;'>\n"
        for n, opt in enumerate(local_docs):
            desc, url = opt
            accesskey = chr(ord("1") + n)
            print '\t<li><a href="%s" accesskey="%s">%s</a></li>\n' % (url, accesskey, desc)
        print "</ol>\n"
        print webpreview.html_footer()
    elif local_docs and not library_docs:
        print "<meta http-equiv='Refresh' content='0;URL=%s'>" % local_docs[0][1]
    else:
        print "<meta http-equiv='Refresh' content='0;URL=%s'>" % docmate.pydoc_url()[0]
PYTHON

EOF
end
