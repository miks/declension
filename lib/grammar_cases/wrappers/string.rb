module GrammarCases
  module Wrappers
    class String
      attr_accessor :string

      def initialize(string)
        @string = string
      end

      def to_grammar_case(grammar_case, options)
        string.split(" ").map{|word| GrammarCases::Word.new(word).to_grammar_case(grammar_case, options) }.join(" ")
      end
    end
  end
end
