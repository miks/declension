module Declension
  module Wrappers
    class String
      attr_accessor :string

      def initialize(string)
        @string = string
      end

      def inflect(grammar_case, options)
        string.split(" ").map{|word| Declension::Word.new(word).inflect(grammar_case, options) }.join(" ")
      end
    end
  end
end
