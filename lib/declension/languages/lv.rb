module Declension
  module Languages
    class Lv < Declension::Languages::Base
      require 'declension/languages/lv/inflections'

      GENDERS = [
        GENDER_MALE = :male,
        GENDER_FEMALE = :female
      ]
      EXCEPTIONAL_MALE_WORDS = %w(mēness akmens asmens rudens ūdens zibens suns sāls)
      CASES = [NOMINATIVE_CASE, GENITIVE_CASE, DATIVE_CASE, ACCUSATIVE_CASE, INSTRUMENTAL_CASE, LOCATIVE_CASE, VOCATIVE_CASE]

      attr_accessor :declension, :ending, :gender, :exception, :word_base

      def analyze_word
        if gender == GENDER_MALE
          analyze_male_gender_word
        elsif gender == GENDER_FEMALE
          analyze_female_gender_word
        else
          raise ArgumentError, "No valid gender specified"
        end

        self.word_base = word[0..-(ending.length + 1)]
      end

      def analyze_male_gender_word
        short_ending = word[-1, 1]
        long_ending = word[-2, 2]

        if EXCEPTIONAL_MALE_WORDS.include? word
          self.exception = true
          self.declension = 2
          self.ending = 's'
        elsif word == 'ļaudis'
          self.exception = true
          self.declension = 6
          self.ending = 'is'
        elsif long_ending == 'is'
          self.declension = 2
          self.ending = long_ending
        elsif long_ending == 'us'
          self.declension = 3
          self.ending = long_ending
        elsif short_ending == 's' || short_ending == 'š'
          self.declension = 1
          self.ending = short_ending
        elsif short_ending == 'a'
          self.declension = 4
          self.ending = short_ending
        elsif short_ending == 'e'
          self.declension = 5
          self.ending = short_ending
        end
      end

      def analyze_female_gender_word
        self.ending = word[-1, 1]

        if ending == 'a'
          self.declension = 4
        elsif ending == 'e'
          self.declension = 5
        elsif ending == 's'
          self.declension = 6
        end
      end

      def assign_options(options)
        self.gender = Array(options[:as]).map(&:to_sym).find{|option| GENDERS.include? option }
      end

      def inflect(grammar_case, options = {})
        assign_options(options)
        analyze_word

        if declension == 1
          first_declension(grammar_case, options = {})
        elsif declension == 2
          second_declension(grammar_case, options = {})
        elsif declension == 3
          third_declension(grammar_case, options = {})
        elsif declension == 4
          forth_declension(grammar_case, options = {})
        elsif declension == 5
          fifth_declension(grammar_case, options = {})
        elsif declension == 6
          sixth_declension(grammar_case, options = {})
        end
      end

      def first_declension(grammar_case, options = {})
        case grammar_case
        when NOMINATIVE_CASE
          word_base + ending
        when GENITIVE_CASE
          word_base + 'a'
        when DATIVE_CASE
          word_base + 'am'
        when ACCUSATIVE_CASE
          word_base + 'u'
        when INSTRUMENTAL_CASE
          'ar ' + word_base + 'u'
        when LOCATIVE_CASE
          word_base + 'ā'
        when VOCATIVE_CASE
          word_base + (ending == 's' ? 's' : 'š') + "!"
        end
      end

      def second_declension(grammar_case, options = {})
        inflected_base = exception ? word_base : Lv::Inflections.inflect(word, word_base, declension)

        case grammar_case
        when NOMINATIVE_CASE
          word_base + ending
        when GENITIVE_CASE
          inflected_base + (ending == 'is' ? 'a' : 's')
        when DATIVE_CASE
          word_base + 'im'
        when ACCUSATIVE_CASE
          word_base + 'i'
        when INSTRUMENTAL_CASE
          'ar ' + word_base + 'i'
        when LOCATIVE_CASE
          word_base + 'ī'
        when VOCATIVE_CASE
          word_base + (ending == 'is' ? 'i!' : '!')
        end
      end

      def third_declension(grammar_case, options = {})
        case grammar_case
        when NOMINATIVE_CASE
          word_base + ending
        when GENITIVE_CASE
          word_base + 'us'
        when DATIVE_CASE
          word_base + 'um'
        when ACCUSATIVE_CASE
          word_base + 'u'
        when INSTRUMENTAL_CASE
          'ar ' + word_base + 'u'
        when LOCATIVE_CASE
          word_base + 'ū'
        when VOCATIVE_CASE
          word_base + '(us|u)!'
        end
      end

      def forth_declension(grammar_case, options = {})
        case grammar_case
        when NOMINATIVE_CASE
          word_base + ending
        when GENITIVE_CASE
          word_base + 'as'
        when DATIVE_CASE
          word_base + (gender == GENDER_MALE ? 'am' : 'ai')
        when ACCUSATIVE_CASE
          word_base + 'u'
        when INSTRUMENTAL_CASE
          'ar ' + word_base + 'u'
        when LOCATIVE_CASE
          word_base + 'ā'
        when VOCATIVE_CASE
          word_base + 'a!'
        end
      end

      def fifth_declension(grammar_case, options = {})
        case grammar_case
        when NOMINATIVE_CASE
          word_base + ending
        when GENITIVE_CASE
          word_base + 'es'
        when DATIVE_CASE
          word_base + (gender == GENDER_MALE ? 'em' : 'ei')
        when ACCUSATIVE_CASE
          word_base + 'i'
        when INSTRUMENTAL_CASE
          'ar ' + word_base + 'i'
        when LOCATIVE_CASE
          word_base + 'ē'
        when VOCATIVE_CASE
          word_base + 'e!'
        end
      end

      def sixth_declension(grammar_case, options = {})
        case grammar_case
        when NOMINATIVE_CASE
          word_base + ending
        when GENITIVE_CASE
          word_base + 's'
        when DATIVE_CASE
          word_base + 'ij'
        when ACCUSATIVE_CASE
          word_base + 'i'
        when INSTRUMENTAL_CASE
          'ar ' + word_base + 'i'
        when LOCATIVE_CASE
          word_base + 'ī'
        when VOCATIVE_CASE
          word_base + 's!'
        end
      end
    end
  end
end
