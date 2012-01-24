require 'ruble'

command 'Validate Syntax (PyCheckMate)' do |cmd|
  cmd.key_binding = 'M4+M2+V'
  cmd.scope = 'source.python'
  cmd.output = :show_as_html
  cmd.input = :none
  cmd.invoke =<<-EOF
TPY=${TM_PYTHON:-python}

"$TPY" "$TM_BUNDLE_SUPPORT/bin/pycheckmate.py" "$TM_FILEPATH"
EOF
end
