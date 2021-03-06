require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module WatchThinkChat
  class Application < Rails::Application
    config.action_view.raise_on_missing_translations = true
    config.i18n.available_locales =
      [:en, :am, :ar, :de, :'es-ES', :fr, :'hi-IN', :hu, :ja,
       :ko,  :nl, :pl, :'pt-BR', :ro, :ru,  :th, :uk, :'zh-CN']
    config.autoload_paths << Rails.root.join('lib')
    config.assets.initialize_on_precompile = false
    config.i18n.default_locale = :en
    config.i18n.load_path +=
      Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  end
end
