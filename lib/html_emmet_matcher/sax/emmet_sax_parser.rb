require 'nokogiri'

module HtmlEmmetMatcher
  module SAX
    class EmmetSaxParser < Nokogiri::XML::SAX::Document
      # Public: Initialization method
      #
      # Returns new instance of self
      def initialize(structure_only)
        @structure_only = structure_only
        @emmet_string = ''
        @current_tag = nil
        @parent_tag = nil
      end
      
      def start_element(name, attrs = [])
        @parent_tag = @current_tag if @current_tag
        @current_tag = name

        @emmet_string << ">" if @parent_tag

        @emmet_string << "#{name}"

        if not attrs.empty?
          attrs.each do |attr|
            @emmet_string << "#{'#'}#{attr[1]}" if attr[0] == 'id'
            @emmet_string << ".#{attr[1]}" if attr[0] == 'class'
          end
        end
      end

      def end_element(name)
        @parent_tag = nil if @current_tag == nil && @parent_tag == name
        @current_tag = nil
      end

      def characters(string)
        unless @structure_only
          @emmet_string << "+" if @parent_tag && !@current_tag # TODO: Needs to be in start_element as well
          # Normalize whitespace
          string.gsub!(/[\r\n]+/, "\n") # Normalize newlines 
          string.gsub!(/\n/, '') # Conscious choice to remove all newlines, TODO: will probably need to be special cased
          string.gsub!(/(\ )+/, ' ')
          @emmet_string << "{#{string}}" unless string.gsub(/\s+/, '').empty?
        end
      end

      # Public: Returns the generated string after parsing is complete
      #
      # Returns the string containing the emmet expression matching HTML 
      # passed to the SAX parser.
      def emmet_string
        @emmet_string
      end
    end
  end
end
