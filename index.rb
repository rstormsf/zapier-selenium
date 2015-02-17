require "selenium-webdriver"
require 'yaml'


@driver = Selenium::WebDriver.for :firefox
@driver.navigate.to "http://zapier.com"


def is_displayed? selector
  begin
    @driver.find_element(:css, selector)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
end

if File.exist? 'cookies.yml'
  cookies = YAML.load(File.read('cookies.yml'))
  cookies.each do |cookie|
    @driver.manage.add_cookie cookie
  end
end

element = @driver.find_element(:css, 'p.signin a')
element.click
sleep 10

if is_displayed? "input#email.account"
  @driver.find_element(:css, 'input#email.account').send_keys(ENV['email'])
  @driver.find_element(:css, 'input#password.password').send_keys(ENV['password'])
  @driver.find_element(:css, "input.submit").click
  sleep 5
end

if is_displayed? ".modal-layer.is_open"
  @driver.find_element(:css, ".x").click
end
zaps = @driver.find_elements(:css, '.live-block div.zaps div[data-zap-id]')
zaps.each do |zap|
  zap.find_element(:css, '.menu-button').click
  @driver.find_element(:css, '.zap-menu a.run').click
  sleep 10
  @driver.find_element(:css, '.x').click
end

File.open('cookies.yml', 'w') { |file|
  cookies = @driver.manage.all_cookies
  cookies.each do |cookie|
    cookie.delete(:domain)
  end
  file.write(YAML.dump cookies)
}
puts "Done"

@driver.quit