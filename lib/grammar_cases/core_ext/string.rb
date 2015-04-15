class String
  def to_grammar_case(grammar_case, options = {})
    GrammarCases::Wrappers::String.new(self).to_grammar_case(grammar_case, options)
  end
end
