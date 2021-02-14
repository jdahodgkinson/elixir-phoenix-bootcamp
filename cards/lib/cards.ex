defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.

  """

  @spec create_deck :: [String.t()]
  @doc """
    Returns a list of strings, representing a deck of playing cards.

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @spec shuffle([String.t()]) :: [String.t()]
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @spec contains?([String.t()], String.t()) :: boolean
  @doc """
    Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      iex> Cards.contains?(deck, "Not a card")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @spec deal([String.t()], integer) :: {[String.t()], [String.t()]}
  @doc """
    Divides a deck into a hand and the remainder of the deck.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @spec save([String.t()], String.t()) :: :ok
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @spec load(String.t()) :: [String.t()] | String.t()
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist."
    end
  end

  @spec create_hand(integer) :: {[String.t()], [String.t()]}
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
