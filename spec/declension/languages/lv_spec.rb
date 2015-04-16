require 'spec_helper'

describe Declension::Languages::Lv do
  let(:word){ "Kods" }
  subject{ described_class.new(word) }

  describe "#assign_options" do
    before do
      subject.gender = "xx"
    end

    context "when no `as` options given" do
      it "sets gender to nil" do
        expect{ subject.assign_options({}) }.to change{ subject.gender }.to(nil)
      end
    end

    context "when `as` options has `:male` value" do
      it "sets gender to `Lv::GENDER_MALE`" do
        expect{ subject.assign_options(as: :male) }.to change{ subject.gender }.to(Declension::Languages::Lv::GENDER_MALE)
      end
    end

    context "when `as` options has `:female` value" do
      it "sets gender to `Lv::GENDER_FEMALE`" do
        expect{ subject.assign_options(as: :female) }.to change{ subject.gender }.to(Declension::Languages::Lv::GENDER_FEMALE)
      end
    end

    context "when `as` options has unknown value" do
      it "sets gender to nil" do
        expect{ subject.assign_options(as: :random) }.to change{ subject.gender }.to(nil)
      end
    end

    it "supports `as` values given as string" do
        expect{ subject.assign_options(as: ["female"]) }.to change{ subject.gender }
          .to(Declension::Languages::Lv::GENDER_FEMALE)
    end

    it "supports arrayable `as` options" do
        expect{ subject.assign_options(as: [:female, :plural]) }.to change{ subject.gender }
          .to(Declension::Languages::Lv::GENDER_FEMALE)
    end
  end

  describe "declension inflections" do
    fixture_file = File.expand_path('../../fixtures/lv.yml', File.dirname(__FILE__))
    test_cases = YAML::load(File.open(fixture_file))
    test_cases.each_pair do|word, meta|
      it "has correct grammar cases for #{word} (#{meta["description"]})" do
        meta["cases"].each_pair do|grammar_case, expectation|
          options = meta["options"].each_with_object({}){|(k,v), h| h[k.to_sym] = v}
          expect(Declension::Languages::Lv.new(word).inflect(grammar_case.to_sym, options)).to eq(expectation)
        end
      end
    end
  end
end
