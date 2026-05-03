class PdfGenerator
  def initialize(template, data)
    @template = template
    @data = data
  end

  def generate
    html = ApplicationController.renderer.render_to_string(layout: "pdf", template: @template, assigns: { data: @data })

    retries ||= 0

    begin
      Grover.new(html, **config).to_pdf
    rescue Grover::JavaScript::TimeoutError => e
      retries += 1
      retry if retries < 3

      puts "TimeoutError: #{e.message}"
    end
  end

  private

  def config
    {
      format: "Letter",
      margin: {
        top: "25px",
        bottom: "5px",
      },
      wait_until: "domcontentloaded",
      launch_args: ["--no-sandbox", "--disable-setuid-sandbox"],
      executable_path: ENV["PUPPETEER_EXECUTABLE_PATH"],
      display_url: display_url,
    }.compact
  end

  def display_url
    port = ENV.fetch("PORT", 3000)
    "http://127.0.0.1:#{port}"
  end
end
