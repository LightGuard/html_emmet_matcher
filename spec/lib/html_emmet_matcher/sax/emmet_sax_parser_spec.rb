require 'spec_helper'
require 'html_emmet_matcher/sax/emmet_sax_parser'

describe 'SAX handler' do
  context 'when structure_only true' do
    it 'converts html into emmet' do
      html_snippet = %(<html>
        <body>
          <div>
            <p>Hello
              <strong>World</strong>
              !
            </p>
          </div>
        </body>
      </html>)

      handler = HtmlEmmetMatcher::SAX::EmmetSaxParser.new true 
      parser = Nokogiri::XML::SAX::Parser.new handler
      parser.parse_memory html_snippet

      handler.emmet_string.should == 'html>body>div>p>strong'
    end
  end
  context 'when structure_only false' do
    it 'converts html into emmet' do
      html_snippet = %(<html>
        <body>
          <div>
            <p>Hello <strong>World</strong>!</p>
          </div>
        </body>
      </html>)

      handler = HtmlEmmetMatcher::SAX::EmmetSaxParser.new false 
      parser = Nokogiri::XML::SAX::Parser.new handler
      parser.parse_memory html_snippet

      handler.emmet_string.should == 'html>body>div>p{Hello }>strong{World}+{!}'
    end
    context 'whitespace should be normalized' do
      it 'converts html into emmet' do
        html_snippet = %(<html>
        <body>
          <div>
            <p>


              Hello <strong>World</strong>!


            </p>
          </div>
        </body>
      </html>)

        handler = HtmlEmmetMatcher::SAX::EmmetSaxParser.new false 
        parser = Nokogiri::XML::SAX::Parser.new handler
        parser.parse_memory html_snippet

        handler.emmet_string.should == 'html>body>div>p{ Hello }>strong{World}+{! }'
      end
    end
  end
end

