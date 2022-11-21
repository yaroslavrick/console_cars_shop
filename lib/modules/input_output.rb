module Lib
  module Modules
    module InputOutput
      def user_input
        gets.chomp.strip
      end

      def show_cars(database)
        database.each do |car|
          car.each do |key, value|
            puts "#{key.capitalize}: #{value}"
          end
          puts
        end
      end

      def ask_field(rule)
        puts "#{localize('choose.please_choose').light_blue} #{localize("choose.#{rule}").light_green}:"
        user_input.downcase
      end

      def show_prettified_result(database)
        return puts 'There is no cars with this parameters' if database.empty?

        rows = flat_data(database)
        table = Terminal::Table.new title: localize('results.title').light_yellow,
                                    headings: [localize('results.params').cyan, localize('results.data').cyan], rows: rows
        table.style = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }
        puts table
      end

      def flat_data(database)
        database.map do |car|
          car.map do |key, value|
            [key.to_s.light_blue, value.to_s.magenta]
          end
        end.flatten(1)
      end

      def show_prettified_statistic(db, requested_quantity)
        rows = [[localize('statistics.total_quantity').light_blue, db.to_s.magenta],
                [localize('statistics.requests_quantity').light_blue, requested_quantity.to_s.magenta]]
        table = Terminal::Table.new title: localize('statistics.statistic').light_yellow,
                                    headings: [localize('statistics.title').cyan, localize('statistics.number').cyan], rows: rows
        table.style = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }
        puts table
      end

      def exit?
        puts "\n#{localize(:exit).cyan}"
        %w[y yes].include?(gets.chomp.downcase)
      end
    end
  end
end
