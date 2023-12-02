# Run as: iex --dot-iex path/to/notebook.exs

# Title: Day 1 - Advent of Code 2023

Mix.install([:kino])

# ── Section ──

example_input_part_one = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""

example_input_part_two = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""

input = Kino.Input.textarea("Please, insert your input here: ")

defmodule DayOne do
  @numbers %{
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9
  }

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  def filter_integers(line) do
    numbers = Enum.filter(line, fn char -> char in ?0..?9 end)
    first_number = hd(numbers)

    last_number =
      numbers
      |> Enum.reverse()
      |> hd

    [first_number, last_number]
    |> List.to_integer()
  end

  def transform_words(input) do
    @numbers
    |> Enum.reduce(input, fn {word, number}, s ->
      String.replace(s, "#{word}", "#{word}#{number}#{word}")
    end)
  end
end

input
|> Kino.Input.read()
|> DayOne.parse_input()
|> Enum.map(&DayOne.filter_integers/1)
|> Enum.sum()

input
|> Kino.Input.read()
|> DayOne.transform_words()
|> DayOne.parse_input()
|> Enum.map(&DayOne.filter_integers/1)
|> Enum.sum()
