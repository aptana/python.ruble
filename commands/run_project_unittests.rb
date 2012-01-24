require 'ruble'

command t(:run_project_unit_tests) do |cmd|
  cmd.key_binding = 'M3+M1+M2+R'
  cmd.scope = 'source.python'
  cmd.output = :show_as_html
  cmd.input = :none
  cmd.invoke =<<-EOF
# Find all files that end with "Test.py" and run 
# them.

find . -name "*Test.py" -exec "${TM_PYTHON:-python}" '{}' \;|pre
EOF
end
