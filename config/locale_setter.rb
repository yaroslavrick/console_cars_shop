module Config
  class LocaleSetter
    include Lib::Modules::Colorize

    def call
      I18n.load_path << Dir["#{File.expand_path('config/locales')}/*.yml"]
      I18n.default_locale = :en
      row = [[colorize_main('en'), colorize_main('ua')]]
      table = Terminal::Table.new headings: %w[English Українська], rows: row
      table.style = Lib::PrintData::TABLE_STYLE
      puts table
      locale = gets.chomp.downcase.to_sym
      I18n.locale = locale == :ua ? locale : :en
    end
  end
end