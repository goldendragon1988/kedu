require "rails_helper"

RSpec.describe PdfGenerator, type: :service do
  describe "#generate" do
    it "passes Grover options as keyword arguments" do
      renderer = instance_double(ActionController::Renderer, render_to_string: "<html>worksheet</html>")
      grover = instance_double(Grover, to_pdf: "pdf-bytes")

      allow(ApplicationController).to receive(:renderer).and_return(renderer)
      expect(Grover).to receive(:new).with(
        "<html>worksheet</html>",
        format: "Letter",
        margin: {
          top: "25px",
          bottom: "5px",
        },
        wait_until: "domcontentloaded",
        display_url: "http://localhost:3000",
      ).and_return(grover)

      pdf = described_class.new("math/addition/pdf", { sample: true }).generate

      expect(pdf).to eq("pdf-bytes")
    end
  end
end
