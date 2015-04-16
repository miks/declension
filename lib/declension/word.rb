module Declension
  class Word
    attr_accessor :word

    def initialize(word)
      self.word = word
    end

    def inflect(grammar_case, options)
      Declension::Languages::Lv.new(word).inflect(grammar_case.to_sym, options)
    end
  end
end
