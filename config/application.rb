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
    
    #gem 'rails-i18n'による日本語化
    config.i18n.default_locale = :ja
    
    #config/application.rbにja.ymlファイルの読み込む一文を追記してあげればOK。
    #これは、正規表現を使い、config/locales以下のディレクトリ内にある全てのymlファイルを読み込むように指示する一文となります。
    
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
  end
end
