module Declension
  class Word
    attr_accessor :word

    def initialize(word)
      self.word = word
    end

    def to_grammar_case(grammar_case, options)
      Declension::Languages::Lv.new(word).to_grammar_case(grammar_case.to_sym, options)
    end
  end
end
