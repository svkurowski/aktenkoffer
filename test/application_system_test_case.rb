require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DRIVER = :firefox
  if ['0', 'false'].include?(ENV["HEADLESS"]&.downcase)
    DRIVER = :headless_firefox
  end
  options = {}
  if not ENV["WEB_DRIVER_URL"].nil?
    Capybara.server_host = "0.0.0.0"
    Capybara.app_host = "http://#{ENV.fetch("HOSTNAME")}:#{Capybara.server_port}"
    options = {
      browser: :remote,
      url: ENV["WEB_DRIVER_URL"]
    }
  end

  driven_by :selenium, using: DRIVER, screen_size: [1400, 1400], options: options
end
