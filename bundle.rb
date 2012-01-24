require 'ruble'

bundle do |bundle|
  bundle_display_name = t(:bundle_name)
  bundle.author = 'Brad Miller'
  bundle.contact_email_rot_13 = 'obarynxr@znp.pbz'
  bundle.description = 'Support for the <a href="http://www.python.org/">Python</a> programming language.'
  
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

  bundle.menu t(:bundle_name) do |main_menu|
    main_menu.command t(:run_script)
    main_menu.command t(:run_script_terminal)
    main_menu.command t(:run_project_unit_tests)
    main_menu.command t(:debug_script_in_terminal)
    main_menu.command t(:execute_as_python)
    main_menu.command t(:validate_syntax)
    main_menu.command t(:cleanup_whitespace)
    main_menu.separator
    main_menu.command t(:docs_in_browser)
    main_menu.command t(:docs_for_module)
    main_menu.separator
    main_menu.menu t(:insert) do |submenu|
      submenu.command t(:new_method_function)
      submenu.command 'self'
      submenu.command '__magic__'
#      submenu.command 'EEFB390C-543A-48E8-B5E5-AAF98A0DAF3C'
    end
    main_menu.menu t(:declarations) do |submenu|
      submenu.command t(:new_class)
      submenu.command t(:new_method)
      submenu.command t(:new_function)
    end
    main_menu.menu t(:idioms) do |submenu|
      submenu.command t(:new_property)
      submenu.command 'if __name__ == \'__main__\''
      submenu.separator
      submenu.command t(:try_except)
      submenu.command t(:try_except_else)
      submenu.command t(:try_except_finally)
      submenu.command t(:try_except_else_finally)
    end
    main_menu.menu t(:tests) do |submenu|
      submenu.command t(:assert)
      submenu.command t(:assert_equal)
      submenu.command t(:assert_not_equal)
      submenu.command t(:assert_raises)
      submenu.command t(:fail_a_test)
    end
    main_menu.separator
    main_menu.command t(:docs_for_word)
    main_menu.command t(:show_symbol)
    main_menu.command t(:copy_symbol)
  end
end
env 'source.python' do |e|
  e['TM_COMMENT_START'] = '# '
  e['TM_LINE_TERMINATOR'] = ':'
end
