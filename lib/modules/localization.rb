# frozen_string_literal: true

module Lib
  module Modules
    module Localization
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
