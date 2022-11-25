module Lib
  module Modules
    module InputOutput
      TABLE_STYLE = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }.freeze

      def user_input
        gets.chomp.strip
      end

      def ask_field(rule)
        puts "#{colorize_main(localize('choose.please_choose'))} #{colorize_option(localize("choose.#{rule}"))}:"
        user_input.downcase
      end

      def show_prettified_result(database)
        return puts colorize_title(localize('results.empty')) if database.empty?

        rows = flat_data(database)
        table = Terminal::Table.new title: colorize_title(localize('results.title')),
                                    headings: [colorize_header(localize('results.params')), colorize_header(localize('results.data'))], rows: rows
        table.style = TABLE_STYLE
        puts table
      end

      def flat_data(database)
        database.map do |car|
          car.map do |key, value|
            [colorize_main(key.to_s), colorize_result(value.to_s)]
          end
        end.flatten(1)
      end

      def exit?
        puts "\n#{localize(:exit).cyan}"
        %w[y yes].include?(gets.chomp.downcase)
      end
    end
  end
end
