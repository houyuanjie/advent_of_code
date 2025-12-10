# frozen_string_literal: true

module FindTheInvalidIDs
  module_function

  def resolve(text)
    ranges = text.delete("\r\n").split(',').map { |range| range.split('-').map(&:to_i) }

    sum = 0

    ranges.each do |range|
      min, max = range
      (min..max).each do |number|
        str = number.to_s
        len = str.length

        next if len.odd?

        prefix = str[..((len / 2) - 1)]
        suffix = str[(len / 2)..]

        sum += number if prefix == suffix
      end
    end

    sum
  end

  def resolve_file(filename)
    resolve(File.read(filename))
  end
end

require 'minitest/autorun'

class FindTheInvalidIDsTest < Minitest::Test
  def test_it_works
    assert_equal 1_227_775_554, FindTheInvalidIDs.resolve(<<~TEXT)
      11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
      1698522-1698528,446443-446449,38593856-38593862,565653-565659,
      824824821-824824827,2121212118-2121212124
    TEXT
  end
end
