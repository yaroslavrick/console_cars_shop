module Lib
  class PrintData
    TABLE_STYLE = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }.freeze
    include Lib::Modules::InputOutput
    include Lib::Modules::Colorize

    def create_table(title_name, first_header, second_header, rows)
      table = Terminal::Table.new(
        title: colorize_title(localize(title_name)),
        headings: [colorize_header(localize(first_header)),
                   colorize_header(localize(second_header))],
        rows:
      )
      table.style = TABLE_STYLE
      puts table
    end
  end
end