# frozen_string_literal: true

module Lib
  module Modules
    module Localization
      I18n.load_path << Dir["#{File.expand_path('config/locales')}/*.yml"]
      I18n.default_locale = :en

      def localize(key)
        I18n.t(key)
      end

      def ask_locale
        puts 'Choose language: EN/ua: '.colorize(:blue)
        lang = gets.chomp.downcase.to_sym
        I18n.locale = lang if I18n.available_locales.include?(lang)
      end
    end
  end
end
