class Numbers
  DEFAULT_COUNT = 33
  REPEATED_ADDITION_COUNT = 12

  def initialize(type, from, to)
    @type = type.to_sym
    @from = from
    @to = to
  end

  def generate
    case @type
    when :max_sum
      generate_add_pair(@from, @to)
    when :random, :addition
      generate_random_pair(@from, @to)
    when :repeated_addition
      generate_repeated_addition_pair(@from, @to)
    when :subtraction, :modulo
      generate_random_pair(@from, @to).map { |pair| pair.sort.reverse }
    when :multiplication
      generate_random_pair(@from, @to)
    when :division
      generate_division_pair(@from, @to)
    when :missing_random
      generate_missing_pair(@from, @to)
    when :missing_addition
      generate_missing_pair(@from, @to, "+")
    when :missing_subtraction
      generate_missing_pair(@from, @to, "-")
    when :missing_multiplication
      generate_missing_pair(@from, @to, "x")
    when :missing_division
      generate_missing_pair(@from, @to, "÷")
    end
  end

  private

  def generate_random_pair(from, to)
    pairs = []

    DEFAULT_COUNT.times do
      pairs << [rand(from..to), rand(from..to)]
    end

    pairs
  end

  def generate_add_pair(from, to)
    pairs = []

    DEFAULT_COUNT.times do
      addend1 = rand(from..to - 1)
      addend2 = rand(from..[to - addend1, to - 1].min)

      pairs << [addend1, addend2]
    end

    pairs
  end

  def generate_repeated_addition_pair(from, to)
    pairs = []

    REPEATED_ADDITION_COUNT.times do
      addend = rand(1..9)
      repeat_count = rand(3..10)

      pairs << Array.new(repeat_count, addend)
    end

    pairs
  end

  def generate_division_pair(from, to)
    pairs = []

    DEFAULT_COUNT.times do
      divisor = rand(from..to)
      quotient = rand(from..to)
      dividend = quotient * divisor

      pairs << [dividend, divisor]
    end

    pairs
  end

  # produce pairs suitable for "missing number" exercises
  # each entry is an array of four elements:
  # [first_operand_or_blank, second_operand_or_blank, result, operator_string]
  # the word "blank" is used for the unknown value.
  # operators include +, -, *, / and the third element is the computed result.
  def generate_missing_pair(from, to, operation = nil)
    pairs = []

    DEFAULT_COUNT.times do
      op = operation || ["+", "-", "x", "÷"].sample

      case op
      when "+"
        a = rand(0..50)
        b = rand(0..50)
        result = a + b
      when "-"
        # ensure non-negative result by picking a >= b
        b = rand(0..99)
        a = rand(b..99)

        result = a - b
      when "x"
        a = rand(1..10)
        b = rand(1..10)
        result = a * b
      when "÷"
        b = rand(1..10)
        result = rand(1..10)
        a = result * b
      end

      # decide which of the three values will be missing
      case rand(3)
      when 0
        pairs << [a, "blank", result, op]
      when 1
        pairs << ["blank", b, result, op]
      when 2
        pairs << [a, b, "blank", op]
      end
    end

    pairs
  end
end
