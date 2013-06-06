require 'nokogiri'

require 'html_emmet_matcher/version'
require 'html_emmet_matcher/sax/emmet_sax_parser'

module HtmlEmmetMatcher
  # Public: Takes an HTML fragment and converts it to an equivilant emmet 
  # string.
  #
  # fragment - String containing the HTML fragment to convert.
  # structure_only - Boolean flag to include text, defaults to true.
  #
  # Returns the emmet string corresponding to the fragment
  def self::parse_fragment(fragment, structure_only = true)
    handler = SAX::EmmetSaxParser.new structure_only
    parser = Nokogiri::HTML::SAX::Parser.new handler
    parser.parse_memory "<fragment>#{fragment}</fragment>"
    handler.emmet_string.sub(/html>body>fragment>/, '')
  end
end
