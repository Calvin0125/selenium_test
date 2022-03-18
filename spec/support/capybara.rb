Capybara.register_driver :chrome_headless do |app|
  chrome_capabilities =
    ::Selenium::WebDriver::Remote::Capabilities.chrome(
      'goog:chromeOptions' => {
        args: %w[no-sandbox headless disable-gpu window-size=1400,1400]
      }
    )

  if ENV['HUB_URL']
    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: ENV['HUB_URL'],
      desired_capabilities: chrome_capabilities
    )
  else
    Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: chrome_capabilities)
  end
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :chrome_headless

    Capybara.server_host = Socket.getaddrinfo(Socket.gethostname, 'echo', Socket::AF_INET)[0][3]
    Capybara.server_port = 3000
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
end
