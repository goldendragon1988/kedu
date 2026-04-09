class Math::MultiplicationController < ApplicationController
  before_action :generate_sample_pair, only: [:pdf, :download]

  layout "pdf", only: [:pdf]

  def download
    file = PdfGenerator.new("math/multiplication/pdf", @data).generate
    send_data(file, filename: "multiplication-#{Time.now.to_i}.pdf", type: "application/pdf", disposition: :inline)
  end

  def pdf; end

  private

  def generate_sample_pair
    service = Numbers.new(:multiplication, params[:from] || 0, params[:to] || 10)
    @data = service.generate
  end
end
