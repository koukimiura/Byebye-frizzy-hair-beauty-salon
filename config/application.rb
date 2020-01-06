require_relative 'boot'

require 'rails/all'



# デフォルトは :log で, 許可されていないパラメータは無視されたうえでログ出力されます.
#config.action_controller.action_on_unpermitted_parameters = :raise
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
