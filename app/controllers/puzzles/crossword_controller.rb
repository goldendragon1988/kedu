module Puzzles
  class CrosswordController < ApplicationController
    before_action :generate_crossword, only: [:pdf, :download]

    layout "pdf", only: [:pdf]

    def download
      file = PdfGenerator.new("puzzles/crossword/pdf", @data).generate
      send_data(file, filename: "crossword-#{Time.now.to_i}.pdf", type: "application/pdf", disposition: :inline)
    end

    def pdf; end

    private

    # placeholder implementation.  eventually this should produce a grid and
    # clue set, but for now just wrap the incoming parameters so the template
    # has something to render.
    def generate_crossword
      clues = params[:clues].to_s.split(/\r?\n/).map(&:strip).reject(&:blank?)
      @data = { clues: clues }
    end
  end
end
