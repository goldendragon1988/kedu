class Math::ModuloController < ApplicationController
  before_action :generate_sample_pair, only: [:pdf, :download]

  layout "pdf", only: [:pdf]

  def download
    file = PdfGenerator.new("math/modulo/pdf", @data).generate
    send_data(file, filename: "modulo-#{Time.now.to_i}.pdf", type: "application/pdf", disposition: :inline)
  end

  def pdf; end

  private

  def generate_sample_pair
    service = Numbers.new(params[:type] || :random, params[:from] || 1, params[:to] || 50)
    @data = service.generate
  end
end