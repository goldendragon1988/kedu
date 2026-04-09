class Words
  WORD_COUNTS = 30
  X_AXIS = 20
  Y_AXIS = 20

  # type        - symbol identifying the puzzle type (:word_search etc.)
  def initialize(type)
    @type = type
  end

  # public entry point used by controllers
  # returns a hash with keys :words and :grid (2‑D matrix of letters)
  def call
    case @type
    when :word_search
      generate_word_search
    else
      {}
    end
  end

  private

  # build a very simple word‑search puzzle.  This is intentionally
  # *not* a production‑grade generator; it just demonstrates reading
  # from the provided CSV and returning a matrix suitable for the view.
  #
  # The returned hash has two keys:
  #   :words – an array of the chosen words (uppercased)
  #   :grid  – a square array of single‑letter strings containing the
  #            words placed horizontally in random rows with the remainder
  #            of the cells filled with random letters.
  def generate_word_search
    path = Rails.root.join("config/initializers/data/words.csv")
    word_list = if File.exist?(path)
                  CSV.read(path).flat_map { |row| row.first.squish }
                else
                  []
                end

    # word_list = %w[
    #   cat
    #   dog
    #   sun
    #   hat
    #   pen
    #   cup
    #   tree
    #   book
    #   moon
    #   star
    #   fish
    #   bird
    #   apple
    #   grape
    #   bread
    #   chair
    #   table
    #   plant
    #   smile
    #   laugh
    #   dance
    #   climb
    #   drink
    #   sleep
    #   happy
    #   funny
    #   tiger
    #   zebra
    #   panda
    #   koala
    # ]

    selected = word_list.map(&:upcase)

    grid = build_grid(selected)

    { words: selected, grid: }
  end

  DIRECTIONS = [
    [0,  1],  # right
    [0, -1],  # left
    [1, 0], # down
    [-1,  0], # up
    [-1,  1], # top-right
    [-1, -1], # top-left
    [1, -1],  # bottom-left
    [1,  1], # bottom-right
  ].freeze

  def build_grid(words)
    # Step 1: 20×20 matrix initialised to 0
    grid = Array.new(Y_AXIS) { Array.new(X_AXIS, 0) }

    words.each do |word|
      placed = false

      until placed
        # Step 2: random starting coordinate
        row = rand(Y_AXIS)
        col = rand(X_AXIS)

        # Step 3: randomly reverse the word
        candidate = [word, word.reverse].sample

        # Step 4 & 5: try each direction in random order
        DIRECTIONS.shuffle.each do |dr, dc|
          end_row = row + (dr * (candidate.length - 1))
          end_col = col + (dc * (candidate.length - 1))

          # word must stay inside the grid
          next if end_row.negative? || end_row >= Y_AXIS
          next if end_col.negative? || end_col >= X_AXIS

          # every cell must be empty (0) or already hold the same letter
          can_place = candidate.chars.each_with_index.all? do |char, i|
            cell = grid[row + (dr * i)][col + (dc * i)]
            cell == 0 || cell == char
          end

          next unless can_place

          candidate.chars.each_with_index do |char, i|
            grid[row + (dr * i)][col + (dc * i)] = char
          end

          placed = true
          break
        end
        # if no direction worked, loop again with a new coordinate
      end
    end

    # Step 6: fill remaining zeros with random letters
    grid.map do |row|
      row.map { |cell| cell == 0 ? ("A".."Z").to_a.sample : cell }
    end
  end
end
