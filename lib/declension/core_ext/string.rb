class String
  def inflect(grammar_case, options = {})
    Declension::Wrappers::String.new(self).inflect(grammar_case, options)
  end
end
