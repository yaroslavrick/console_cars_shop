module Lib
  class PrintData
    TABLE_STYLE = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }.freeze
    include Lib::Modules::InputOutput
    include Lib::Modules::Colorize

    def create_table(title_name, first_header, second_header, rows)
      table = Terminal::Table.new(
        title: colorize_text('title', localize(title_name)).underline,
        headings: [colorize_text('header', localize(first_header)).underline,
                   colorize_text('header', localize(second_header)).underline],
        rows:
      )
      table.style = TABLE_STYLE
      puts table
    end
  end
end