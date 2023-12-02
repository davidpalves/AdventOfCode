# Title: Day 1 - Advent of Code 2023

# Kino can be used in case this is being run on a elixir's livebook
# Mix.install([:kino])

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


# Kino can be used in case this is being run on a elixir's livebook
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

  @doc """
  Filters characters that match digits between [0..9]
  and transforms it to a list of integer
  """
  def filter_integers(line) do
    numbers = Enum.filter(line, fn char -> char in ?0..?9 end) # Filter characters that are digits

    first_number = hd(numbers)
    last_number = List.last(numbers)

    [first_number, last_number] |> List.to_integer()
  end

  @doc """
  Transforms a number into a parseable digit
  surrounded by the written nubmer to be processed
  by the rest of the solution.

  In order for the solution to work with
  overlapping words, I decided to surround the parsed digit with the word,
  so it would not affect prior or later possible parseable words

  ## Example
  iex> transform_words("eightwothree")
  eight8eightwo2twothree3three

  """
  def transform_words(input) do
    @numbers
    |> Enum.reduce(input, fn {word, number}, s ->
      String.replace(s, "#{word}", "#{word}#{number}#{word}")
    end)
  end
end


# Part 1
input
|> Kino.Input.read() # Kino can be used in case this is being run on a elixir's livebook
|> DayOne.parse_input()
|> Enum.map(&DayOne.filter_integers/1)
|> Enum.sum()

# Part 2
input
|> Kino.Input.read() # Kino can be used in case this is being run on a elixir's livebook
|> DayOne.transform_words()
|> DayOne.parse_input()
|> Enum.map(&DayOne.filter_integers/1)
|> Enum.sum()
