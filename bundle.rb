require 'ruble'

bundle 'Python' do |bundle|
  bundle.author = 'Brad Miller'
  bundle.contact_email_rot_13 = 'obarynxr@znp.pbz'
  bundle.description =  <<END
Support for the <a href="http://www.python.org/">Python</a> programming language.
END
  increase_indent = /^\s*(class|def|elif|else|except|finally|for|if|try|with|while)\b.*:\s*$/
  decrease_indent = /^\s*(elif|else|except|finally)\b.*:/
  bundle.indent['source.python'] = increase_indent, decrease_indent
  start_folding = /^\s*(def|class)\s+([.a-zA-Z0-9_ <]+)\s*(\((.*)\))?\s*:|\{\s*$|\(\s*$|\[\s*$|^\s*"""(?=.)(?!.*""")/
  end_folding = /^\s*$|^\s*\}|^\s*\]|^\s*\)|^\s*"""\s*$/
  bundle.folding['source.python'] = start_folding, end_folding
  start_folding = /(\/\*|\{|\()/
  end_folding = /(\*\/|\}|\))/
  bundle.folding['source.regexp.python'] = start_folding, end_folding
  bundle.file_types['source.python'] = '*.py', '*.rpy', '*.pyw', '*.cpy', 'SConstruct', 'Sconstruct', '*.sconstruct', 'SConscript'
  bundle.file_types['source.regexp.python'] = '*.re'

  bundle.menu 'Python' do |main_menu|
    main_menu.command 'Run Script'
    main_menu.command 'Run Script (Terminal)'
    main_menu.command 'Run Project Unit Tests'
    main_menu.command 'Debug Script in Terminal'
    main_menu.command 'Execute Line/Selection as Python'
    main_menu.command 'Validate Syntax (PyCheckMate)'
    main_menu.command 'Cleanup Whitespace'
    main_menu.separator
    main_menu.command 'Documentation in Browser'
    main_menu.command 'Documentation for Module'
    main_menu.separator
    main_menu.menu 'Insert' do |submenu|
      submenu.command 'New Method/Function'
      submenu.command 'self'
      submenu.command '__magic__'
#      submenu.command 'EEFB390C-543A-48E8-B5E5-AAF98A0DAF3C'
    end
    main_menu.menu 'Declarations' do |submenu|
      submenu.command 'New Class'
      submenu.command 'New Method'
      submenu.command 'New Function'
    end
    main_menu.menu 'Idioms' do |submenu|
      submenu.command 'New Property'
      submenu.command 'if __name__ == \'__main__\''
      submenu.separator
      submenu.command 'Try/Except'
      submenu.command 'Try/Except/Else'
      submenu.command 'Try/Except/Finally'
      submenu.command 'Try/Except/Else/Finally'
    end
    main_menu.menu 'Tests' do |submenu|
      submenu.command 'Assert'
      submenu.command 'Assert Equal'
      submenu.command 'Assert Not Equal'
      submenu.command 'Assert Raises'
      submenu.command 'Fail (a test)'
    end
    main_menu.separator
    main_menu.command 'Documentation for Current Word'
    main_menu.command 'Show Symbol'
    main_menu.command 'Copy Symbol'
  end
end
env 'source.python' do |e|
  e['TM_COMMENT_START'] = '# '
  e['TM_LINE_TERMINATOR'] = ':'
end
