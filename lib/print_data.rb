module Lib
  class PrintData
    include Lib::Modules::Localization
    include Lib::Modules::Colorize

    def create_table(title_name, first_header, second_header, rows)
      table = Terminal::Table.new(
        title: colorize_title(localize(title_name)),
        headings: [colorize_header(localize(first_header)),
                   colorize_header(localize(second_header))],
        rows:
      )
      table.style = Lib::Modules::InputOutput::TABLE_STYLE
      puts table
    end
  end
end