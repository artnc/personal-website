# https://talk.jekyllrb.com/t/how-do-you-make-jekyll-execute-liquid-variables-in-front-matter/1638/7
# http://acegik.net/blog/ruby/jekyll/plugins/howto-nest-liquid-template-variables-inside-yaml-front-matter-block.html

module Jekyll
  module FlattenFilter
    def flatten(input)
      Liquid::Template.parse(input).render(@context)
    end
  end
end

Liquid::Template.register_filter(Jekyll::FlattenFilter)
