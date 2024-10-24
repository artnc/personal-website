module Jekyll
  module RegexReplaceFilter
    def regex_replace(input, pattern, repl)
      input.gsub(/#{pattern}/m, repl)
    end
  end
end

Liquid::Template.register_filter(Jekyll::RegexReplaceFilter)
