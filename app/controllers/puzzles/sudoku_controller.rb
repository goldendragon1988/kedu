module Puzzles
  class SudokuController < ApplicationController
    before_action :generate_sudoku, only: [:pdf, :download]

    layout "pdf", only: [:pdf]

    def download
      file = PdfGenerator.new("puzzles/sudoku/pdf", @data).generate
      send_data(file, filename: "sudoku-#{Time.now.to_i}.pdf", type: "application/pdf", disposition: :inline)
    end

    def pdf; end

    private

    # simple 9x9 grid filled with nils; real logic can be swapped in later
    def generate_sudoku
      @data = Array.new(9) { Array.new(9, nil) }
    end
  end
end
