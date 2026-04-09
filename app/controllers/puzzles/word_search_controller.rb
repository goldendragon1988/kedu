module Puzzles
  class WordSearchController < ApplicationController
    before_action :generate_word_search, only: [:pdf, :download]

    layout "pdf", only: [:pdf]

    def download
      file = PdfGenerator.new("puzzles/word_search/pdf", @data).generate
      send_data(file, filename: "word-search-#{Time.now.to_i}.pdf", type: "application/pdf", disposition: :inline)
    end

    def pdf; end

    private

    def generate_word_search
      service = Words.new(:word_search, params[:difficulty] || "easy")
      @data = service.call
    end
  end
end
