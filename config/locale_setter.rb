# frozen_string_literal: true

module Config
  class LocaleSetter
    include Lib::Modules::Colorize

    def call
      row = [[colorize_text('main', 'en'), colorize_text('main', 'ua')]]
      table = Terminal::Table.new headings: %w[English Українська], rows: row
      table.style = Lib::PrintData::TABLE_STYLE
      puts table
      lang = gets.chomp.downcase.to_sym
      I18n.locale = lang if I18n.available_locales.include?(lang)
    end
  end
end
