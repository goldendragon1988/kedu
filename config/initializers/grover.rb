Grover.configure do |config|
  config.options = {
    args: [ "--no-sandbox", "--disable-setuid-sandbox" ]
  }
end
