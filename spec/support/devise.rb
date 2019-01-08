require 'devise'

RSpec.configure do |config|
  [:controller].each do |type|
    config.include Devise::Test::ControllerHelpers, type: type
  end
end
