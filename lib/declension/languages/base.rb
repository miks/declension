module Declension
  module Languages
    class Base
      attr_accessor :word

      def initialize(word)
        @word = word
      end

      def inflect(grammar_case, options = {})
	word
      end
    end
  end
end
