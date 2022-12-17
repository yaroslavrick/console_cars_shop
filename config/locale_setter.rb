module Config
  class LocaleSetter
    include Lib::Modules::Colorize

    def call
      row = [['en'.colorize(:blue), 'ua'.colorize(:blue)]]
      table = Terminal::Table.new headings: %w[English Українська], rows: row
      table.style = Lib::Modules::InputOutput::TABLE_STYLE
      puts table
      locale = gets.chomp.downcase.to_sym
      I18n.locale = locale == :ua ? locale : :en
    end
  end
end