require 'spec_helper'

describe Declension::Languages::Lv do
  fixture_file = File.expand_path('../../fixtures/lv.yml', File.dirname(__FILE__))
  test_cases = YAML::load(File.open(fixture_file))
  test_cases.each_pair do|word, options|
    it "has correct grammar cases for #{word} (#{options["description"]})" do
      options["cases"].each_pair do|grammar_case, expectation|
        expect(Declension::Languages::Lv.new(word).to_grammar_case(grammar_case.to_sym, gender: options["gender"])).to eq(expectation)
      end
    end
  end
end
