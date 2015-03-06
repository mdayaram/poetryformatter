#!/usr/bin/env ruby

require_relative './config/environment'

get '/styles/:file.css' do
  scss params[:file].to_sym
end

get '/' do
  haml :index
end

post '/' do
  @title = params[:title]
  @author = params[:author]
  @inpoetry = params[:inpoetry]
  @outpoetry = format_poem(@title, @author, @inpoetry)
  haml :index
end

def format_poem(title, author, inpoetry)
  num_tabs = 1
  newlines = []
  lines = inpoetry.lines.map(&:chomp)
  first_line = true

  newlines << tab(num_tabs) + "<div class=\"PoemStanza\">"
  lines.each do |line|
    # Remove starting and ending whitespace
    line = line.strip

    # Stanza break for line breaks.
    if line.empty? #empty line, stanza break
      newlines << tab(num_tabs) + "</div>"
      newlines << tab(num_tabs) + "<div class=\"PoemStanza\">"
      first_line = true
      next
    end

    # Replace quote characters.
    line = encode_specials(line)

    # Wrap line with appropriate html p tags
    newl = tab(num_tabs + 1)
    newl += "<p class=\"PoemLine#{1 unless !first_line}\">"
    newl += line + "</p>"
    newlines << newl

    if first_line
      first_line = false
    end
  end
  newlines << tab(num_tabs) + "</div>"

  return header(title, author) + newlines.join("\n") + footer
end

def encode_specials(text)
  # Not a comprehensive list, but should be good enough.
  text = text.gsub("&", "&amp;")
  text = text.gsub("'", "&apos;")
  text = text.gsub("\"", "&quot;")
end

def tab(num = 1)
  "\t" * num
end

def linkify(text)
  if text.nil?
    return ""
  end
  text = text.downcase.gsub(" ", "-")
  text = text.gsub("\"", "")
  text = text.gsub("'", "")
  text = text.gsub("*", "")
  text = text.gsub("$", "")
  text = text.gsub("?", "")
  text = text.gsub("!", "")
end

def header(title, author)
  %{
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <title>#{encode_specials(title)}</title>
  <link href="assets/stylesheets/YBReview_fennel.css" rel="stylesheet" type="text/css" />
  <link href="assets/stylesheets/YBReview_eggplant.css" media="amzn-mobi" rel="stylesheet" type="text/css" />
</head>

<body lang="EN-US">
  <h3 class="Section poem-title" id="#{linkify(title)}">#{encode_specials(title)}</h3>
  <h4><a href="##{linkify(author)}">#{encode_specials(author)}</a></h4>
  }
end

def footer
  %{
</body>
</html>
  }
end
