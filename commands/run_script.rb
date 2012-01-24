require 'ruble'

command 'Run Script' do |cmd|
  cmd.key_binding = 'M1+R'
  cmd.scope = 'source.python'
  cmd.output = :show_as_html
  cmd.input = :document
  cmd.invoke do |context|
    TextMate.save_current_document
    TextMate::Executor.make_project_master_current_document
    
    ENV["PYTHONPATH"] = ENV["TM_BUNDLE_SUPPORT"] + (ENV.has_key?("PYTHONPATH") ? ":" + ENV["PYTHONPATH"] : "")
    
    is_test_script = ENV["TM_FILEPATH"] =~ /(?:\b|_)(?:test)(?:\b|_)/ or
                     File.read(ENV["TM_FILEPATH"]) =~ /\bimport\b.+(?:unittest)/
    
    TextMate::Executor.run(ENV["TM_PYTHON"] || "python", "-u", ENV["TM_FILEPATH"]) do |str, type|
      if is_test_script and type == :err
        if str =~ /\A[\.F]*\Z/
          str.gsub!(/(\.|F)/, "<span class=\"test ok\">\\1</span>")
          str + "<br/>\n"
        elsif str =~ /\A(FAILED.*)\Z/
          "<div class=\"test fail\">#{htmlize $1}</div>\n"
        elsif str =~ /\A(OK.*)\Z/
          "<div class=\"test ok\">#{htmlize $1}</div>\n"
        elsif str =~ /^(\s+)File "(.+)", line (\d+), in (.*)/
          indent = $1
          file   = $2
          line   = $3
          method = $4
          indent += " " if file.sub!(/^\"(.*)\"/,"\1")
          url = "&amp;url=file://" + e_url(file)
          display_name = ENV["TM_DISPLAYNAME"]
          "#{htmlize(indent)}<a class=\"near\" href=\"txmt://open?line=#{line + url}\">" +
            (method ? "method #{CGI::escapeHTML method}" : "<em>at top level</em>") +
            "</a> in <strong>#{CGI::escapeHTML display_name}</strong> at line #{line}<br/>\n"
        end
      end
    end
  end
end
