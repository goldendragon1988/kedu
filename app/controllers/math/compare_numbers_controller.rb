class Math::CompareNumbersController < ApplicationController
  before_action :generate_sample_pair, only: [:pdf, :download]

  layout "pdf", only: [:pdf]

  def download
    file = PdfGenerator.new("math/compare_numbers/pdf", @data).generate
    send_data(file, filename: "compare_numbers-#{Time.now.to_i}.pdf", type: "application/pdf", disposition: :inline)
  end

  def pdf; end

  private

  def generate_sample_pair
    service = Numbers.new(:random, params[:from] || 0, params[:to] || 99)
    @data = service.generate
  end
end
