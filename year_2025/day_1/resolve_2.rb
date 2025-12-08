# frozen_string_literal: true

module TurnTheDial
  module_function

  def resolve(text)
    dial = 50
    count = 0

    text.lines.each do |line|
      direction = line[0] == 'L' ? -1 : 1
      distance = line[1..].to_i

      distance.times do
        dial += direction

        dial += 100 if dial.negative?
        dial -= 100 if dial >= 100

        count += 1 if dial.zero?
      end
    end

    count
  end

  def resolve_file(filename)
    resolve(File.read(filename))
  end
end

require 'minitest/autorun'

class TurnTheDialTest < Minitest::Test
  def test_it_works
    assert_equal 6, TurnTheDial.resolve(<<~TEXT)
      L68
      L30
      R48
      L5
      R60
      L55
      L1
      L99
      R14
      L82
    TEXT
  end
end
