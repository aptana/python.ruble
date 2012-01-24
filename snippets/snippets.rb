require 'ruble'

with_defaults :scope => 'source.python' do

  snippet '__magic__' do |s|
    s.trigger = '__'
    s.expansion = '__${1:init}__'
  end

  snippet t(:assert_equal) do |s|
    s.trigger = 'ase'
    s.expansion = 'self.assertEqual(${1:expected}, ${2:actual}${3:, \'${4:message}\'})$0'
  end

  snippet t(:assert_not_equal) do |s|
    s.trigger = 'asne'
    s.expansion = 'self.assertNotEqual(${1:expected}, ${2:actual}${3:, \'${4:message}\'})$0'
  end

  snippet t(:assert_raises) do |s|
    s.trigger = 'asr'
    s.expansion = 'self.assertRaises(${1:exception}, ${2:callable})$0'
  end

  snippet t(:assert) do |s|
    s.trigger = 'as'
    s.expansion = 'self.assert_(${1:boolean expression}${2:, \'${3:message}\'})$0'
  end

  snippet t(:fail_a_test) do |s|
    s.trigger = 'fail'
    s.expansion = 'self.fail(\'${1:message}\')$0'
  end

  snippet 'if __name__ == \'__main__\'' do |s|
    s.trigger = 'ifmain'
    s.expansion = 'if __name__ == \'__main__\':
	${1:main()}$0'
  end

  snippet t(:new_class) do |s|
    s.trigger = 'class'
    s.expansion = 'class ${1:ClassName}(${2:object}):
	${3/.+/"""/}${3:docstring for $1}${3/.+/"""\n/}${3/.+/\t/}def __init__(self${4/([^,])?(.*)/(?1:, )/}${4:arg}):
		${5:super($1, self).__init__()}
${4/(\A\s*,\s*\Z)|,?\s*([A-Za-z_][a-zA-Z0-9_]*)\s*(=[^,]*)?(,\s*|$)/(?2:\t\tself.$2 = $2\n)/g}		$0'
  end

  snippet t(:new_function) do |s|
    s.trigger = 'def'
    s.expansion = 'def ${1:fname}(${2:`if [ "$TM_CURRENT_LINE" != "" ]
				# poor man\'s way ... check if there is an indent or not
				# (cuz we would have lost the class scope by this point)
				then
					echo "self"
				fi`}):
	${3/.+/"""/}${3:docstring for $1}${3/.+/"""\n/}${3/.+/\t/}${0:pass}'
  end

  snippet t(:new_method) do |s|
    s.trigger = 'defs'
    s.expansion = 'def ${1:mname}(self${2/([^,])?.*/(?1:, )/}${2:arg}):
	${3:pass}'
  end

  snippet t(:new_property) do |s|
    s.trigger = 'property'
    s.expansion = 'def ${1:foo}():
    doc = "${2:The $1 property.}"
    def fget(self):
        ${3:return self._$1}
    def fset(self, value):
        ${4:self._$1 = value}
    def fdel(self):
        ${5:del self._$1}
    return locals()
$1 = property(**$1())$0'
  end

  snippet 'self' do |s|
    s.trigger = '.'
    s.expansion = 'self.'
  end

  with_defaults :trigger => 'try' do
    snippet t(:try_except) do |s|
      s.expansion = 'try:
	${1:pass}
except ${2:Exception}, ${3:e}:
	${4:raise $3}'
    end

    snippet t(:try_except_else) do |s|
      s.expansion = 'try:
	${1:pass}
except ${2:Exception}, ${3:e}:
	${4:raise $3}
else:
	${5:pass}'
    end

    snippet t(:try_except_else_finally) do |s|
      s.expansion = 'try:
	${1:pass}
except${2: ${3:Exception}, ${4:e}}:
	${5:raise}
else:
	${6:pass}
finally:
	${7:pass}'
    end

    snippet t(:try_except_finally) do |s|
      s.expansion = 'try:
	${1:pass}
except ${2:Exception}, ${3:e}:
	${4:raise $3}
finally:
	${5:pass}'
    end
  end
end

# snippet 'Inside Class Def: Insert (..):' do |s|
# # FIXME No tab trigger, probably needs to become command
  # s.key_binding = '('
  # s.scope = 'source.python meta.class.python invalid.illegal.missing-inheritance.python'
  # s.expansion = '(${1:object}):$0'
# end
# 
# snippet 'Inside Function Def: Insert (..):' do |s|
# # FIXME No tab trigger, probably needs to become command
  # s.key_binding = '('
  # s.scope = 'source.python meta.function.python invalid.illegal.missing-parameters.python'
  # s.expansion = '($0):'
# end
# 
# snippet 'Inside String: Insert "..."' do |s|
# # FIXME No tab trigger, probably needs to become command
  # s.key_binding = '"'
  # s.scope = 'source.python string.quoted.double.single-line meta.empty-string.double'
  # s.expansion = '"$0"'
# end
# 
# snippet 'Inside String: Insert \'...\'' do |s|
# # FIXME No tab trigger, probably needs to become command
  # s.key_binding = '\''
  # s.scope = 'source.python string.quoted.single.single-line meta.empty-string.single'
  # s.expansion = '\'$0\''
# end
