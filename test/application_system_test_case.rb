require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DRIVER = ['0', 'false'].include?(ENV["HEADLESS"]&.downcase) ? :chrome : :headless_chrome

  driven_by :selenium, using: DRIVER, screen_size: [1400, 1400]
end
