module Declension
  module Languages
    class Lv::Inflections
      attr_accessor :declension, :word, :word_base

      INFLECTIONS = {
        2 => {
          1 => {'b' => 'bj', 'm' => 'mj', 'p' => 'pj', 'v' => 'vj', 't' => 'š', 'd' => 'ž', 'c' => 'č', 's' => 'š', 'z' => 'ž', 'n' => 'ņ', 'l' => 'ļ'},
          2 => {'dz' => 'dž', 'sn' => 'šņ', 'zn' => 'žņ', 'sl' => 'šļ', 'zl' => 'žļ', 'ln' => 'ļņ'}
        },
        5 => {
          1 => {'b' => 'bj', 'm' => 'mj', 'p' => 'pj', 'v' => 'vj', 'c' => 'č', 't' => 'š', 'd' => 'ž', 's' => 'š', 'z' => 'ž', 'n' => 'ņ', 'l' => 'ļ'},
          2 => {'sn' => 'šņ', 'zn' => 'žņ', 'dz' => 'dž'},
          3 => {'kst' => 'kp'}
        },
        6 => {
          1 => {'v' => 'vj', 't' => 'š', 'd' => 'ž', 's' => 'š', 'z' => 'ž', 'n' => 'ņ', 'l' => 'ļ'},
          2 => {'sn' => 'šņ', 'st' => 'š'}
        }
      }

      def self.inflect(word, word_base, declension)
        inflection = new(word, word_base, declension)
        if inflection.exceptionable?
          word_base
        else
          inflection.inflect
        end
      end

      def initialize(word, word_base, declension)
        self.word = word
        self.word_base = word_base
        self.declension = declension
      end

      def inflect
        [3, 2, 1].each do|iteration|
          ending = word_base[-iteration, iteration]
          INFLECTIONS.fetch(declension, {}).fetch(iteration, {}).each_pair do|key, value|
            return (word_base[0..-(iteration + 1)] + value) if key == ending
          end
        end

        word_base
      end

      def exceptionable?
        if declension == 2
            word == 'tētis' ||
            word == 'viesis' ||
            word[-5, 5] == 'astis' ||
            word[-3, 3] == 'jis' ||
            word[-3, 3] == 'ķis' ||
            word[-3, 3] == 'ģis' ||
            word[-3, 3] == 'ris' ||
            word[-6, 6] == 'skatis'
        end
      end
    end
  end
end
