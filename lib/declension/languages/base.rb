module Declension
  module Languages
    class Base
      attr_accessor :word

      def initialize(word)
        @word = word
      end

      def to_grammar_case(grammar_case, options = {})
	word
      end
    end
  end
end
