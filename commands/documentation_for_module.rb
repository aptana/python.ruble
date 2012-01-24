require 'ruble'

command 'Documentation for Module' do |cmd|
  cmd.key_binding = 'F3'
  cmd.scope = 'source.python'
  cmd.output = :show_as_html
  cmd.input = :none
  cmd.invoke =<<-EOF
# This command takes the currently selected word and
# displays the python documentation for the module
# corresponding to said word.
#
# It falls back on the current word.

# change to /tmp to avoid possibly overwriting
# an html file in the working directory.
cd /tmp

: ${TM_SELECTED_TEXT:=$TM_CURRENT_WORD}
pydoc -w "$TM_SELECTED_TEXT" >/dev/null
if [[ -f "$TM_SELECTED_TEXT.html" ]]; then
	cat "$TM_SELECTED_TEXT.html"
	rm -f "$TM_SELECTED_TEXT.html"
else
	echo "<p>No documentation found for:<pre>$TM_SELECTED_TEXT</pre><p>This command only looks for Python modules."
fi

EOF
end
