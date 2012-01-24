require 'ruble'

command t(:docs_in_browser) do |cmd|
  cmd.key_binding = 'M4+M2+H'
  cmd.scope = 'source.python'
  cmd.output = :show_as_html
  cmd.input = :none
  cmd.invoke =<<-EOF
TPY=${TM_PYTHON:-python}

echo '<html><body>'
"$TPY" "${TM_BUNDLE_SUPPORT}/browse_pydocs.py"
echo '</body></html>'
EOF
end
