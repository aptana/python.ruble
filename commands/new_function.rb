require 'ruble'

command 'New Method/Function' do |cmd|
  cmd.key_binding = 'M2+ENTER'
  cmd.scope = 'source.python'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :word
  cmd.invoke =<<-EOF
#!/usr/bin/env python -S
# coding: utf-8

# This program takes in the name of one of python's special methods, and
# spits a snippet out.  If the name is unknown, make a regular (non-magic)
# method/function

# these functions take no argument except 'self'
selfList = (
    'del', 'repr', 'str', 'hash', 'nonzero', 'unicode', 'len', 'iter', 'neg',
    'pos', 'abs', 'invert', 'complex', 'int', 'long', 'float', 'oct', 'hex',
    'index', 'enter'
)
# these binary operators take both 'self' and 'other' as arguments
selfOtherList = (
 'lt', 'le', 'eq', 'ne', 'gt', 'ge', 'cmp', 'add', 'sub', 'mul', 'floordiv',
 'mod', 'divmod', 'lshift', 'rshift', 'and', 'xor', 'or', 'div', 'truediv',
 'radd', 'rsub', 'rmul', 'rdiv', 'rtruediv', 'rfloordiv', 'rmod', 'rdivmod',
 'rpow', 'rlshift', 'rrshift', 'rand', 'rxor', 'ror', 'iadd', 'isub', 'imul',
 'idiv', 'itruediv', 'ifloordiv', 'imod', 'ilshift', 'irshift', 'iand',
 'ixor', 'ior', 'coerce', 'pow', 'ipow'
)
# these functions take some argument(s) other than self
selfAndMore = {
         'getattr' : 'name',
         'delattr' : 'name',
    'getattribute' : 'name',
         'setattr' : 'name, value',
         'getitem' : 'key',
         'delitem' : 'key',
         'setitem' : 'key, value',
             'get' : 'instance, owner',
             'set' : 'instance, value',
          'delete' : 'instance',
        'contains' : 'item',
        'setslice' : 'i, j, sequence',
        'delslice' : 'i, j',
            'exit' : 'exc_type, exc_value, traceback',
}

sPass = '\t${4/.+/"""/}${4:docstring for %s}${4/.+/"""\n/}${4/.+/\t/}${0:pass}'

def defLine(func, args):
    return ''.join(["def __", func, "__(", args, "):\n", sPass])

def make_snippet(name):
    if name in selfList:
        return defLine(name, 'self')
    
    elif name in selfOtherList:
        return defLine(name, 'self, other')
    
    elif name in selfAndMore:
        return defLine(name, 'self, ' + selfAndMore[name])
    
    elif name in ('init', 'call', 'new'):
        return defLine(name, 'self${2/([^,])?.*/(?1:, )/}${2:arg}')
        
    else:
        return ''.join(['def ', name, '(${3:self${2/([^,])?.*/(?1:, )/}${2:arg}}):\n', sPass % name])

# actually print the thing out, using the current word in TM
from os import environ as env
from sys import exit
try:
    print make_snippet(env['TM_CURRENT_WORD'])
except KeyError:
    print 'Please type the new function\'s name\n(you can also use def?).'
    exit(206)
EOF
end
