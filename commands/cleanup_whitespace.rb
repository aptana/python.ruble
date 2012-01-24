require 'ruble'

command t(:cleanup_whitespace) do |cmd|
  cmd.scope = 'source.python'
  cmd.output = :replace_selection
  cmd.input = :selection
  cmd.invoke =<<-EOF
"${TM_PYTHON:-python}" "${TM_BUNDLE_SUPPORT}/cleanup_whitespace.py"
EOF
end
