class String
  def to_grammar_case(grammar_case, options = {})
    Declension::Wrappers::String.new(self).to_grammar_case(grammar_case, options)
  end
end
