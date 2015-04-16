require 'spec_helper'

describe Declension do
  it "correctly handles grammar case conversion for multiple words" do
    expect("Jānis Liepiņš".to_grammar_case(Declension::DATIVE_CASE, gender: "male")).to eq("Jānim Liepiņam")
    expect("Sabīne Kristovska".to_grammar_case(Declension::DATIVE_CASE, gender: "female")).to eq("Sabīnei Kristovskai")
  end
end
