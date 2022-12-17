# frozen_string_literal: true

module Lib
  class PrintData
    include Lib::Modules::InputOutput
    include Lib::Modules::Colorize
    TABLE_STYLE = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }.freeze

    def create_table(title_name, first_header, second_header, rows)
      table = Terminal::Table.new(
        title: colorize_text('title', localize(title_name)).underline,
        headings: [colorize_text('header', localize(first_header)).underline,
                   colorize_text('header', localize(second_header)).underline],
        rows: rows
      )
      table.style = TABLE_STYLE
      puts table
    end

    def print_help_menu
      puts
      puts colorize_text('result', localize('main_menu.help_menu.search_car'))
      puts colorize_text('result', localize('main_menu.help_menu.show_all_cars'))
      puts colorize_text('result', localize('main_menu.help_menu.help'))
      puts colorize_text('result', localize('main_menu.help_menu.exit'))
      puts
    end

    def show_error_wrong_input
      puts colorize_text('error', localize('main_menu.wrong_input'))
    end
  end
end
