require 'spec_helper'
require 'html_emmet_matcher'

describe 'conversion' do
  context 'using SAX' do 
    context 'when structure only' do
      it 'converts html into emmet' do
        html_snippet = %(<div id="preamble">
      <div class="sectionbody">
        <div class="paragraph">
          <p>This is 
            <strong>AsciiDoc</strong>
             in Awestruct
          </p>
        </div>
      </div>
    </div>)

        emmet_string = HtmlEmmetMatcher.parse_fragment(html_snippet)

        emmet_string.should == 'div#preamble>div.sectionbody>div.paragraph>p>strong'
        #emmet_string.should == 'div#preamble>div.sectionbody>div.paragraph>p{This is }>strong{AsciiDoc}+{ in Awestruct}' # for matching content too
      end
    end
    context 'when converting everything' do
      it 'converts html into emmet' do
        html_snippet = %(<div id="preamble">
      <div class="sectionbody">
        <div class="paragraph">
          <p>This is 
            <strong>AsciiDoc</strong>
             in Awestruct
          </p>
        </div>
      </div>
    </div>)

        emmet_string = HtmlEmmetMatcher.parse_fragment(html_snippet, false)

        emmet_string.should == 'div#preamble>div.sectionbody>div.paragraph>p{This is }>strong{AsciiDoc}+{ in Awestruct }' # for matching content too
      end
    end
  end
end

