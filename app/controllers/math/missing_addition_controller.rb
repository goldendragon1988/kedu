class Math::MissingAdditionController < ApplicationController
  before_action :generate_sample_pair, only: [:pdf, :download]

  layout "pdf", only: [:pdf]

  def download
    file = PdfGenerator.new("math/missing_addition/pdf", @data).generate
    send_data(file, filename: "missing_addition-#{Time.now.to_i}.pdf", type: "application/pdf", disposition: :inline)
  end

  def pdf; end

  private

  def generate_sample_pair
    service = Numbers.new(:missing_addition, params[:from] || 0, params[:to] || 50)
    @data = service.generate
  end
end
