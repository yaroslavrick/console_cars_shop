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
        puts "#{I18n.t('choose.please_choose').light_blue} #{I18n.t("choose.#{rule}").light_green}:"
        user_input.downcase
      end

      def show_prettified_result(database)
        rows = flat_data(database)
        table = Terminal::Table.new title: I18n.t('results.title').light_yellow,
                                    headings: [I18n.t('results.params').cyan, I18n.t('results.data').cyan], rows: rows
        table.style = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }
        puts table
      end

      def flat_data(database)
        database.flat_map do |car|
          car.map do |key, value|
            [key.to_s.light_blue, value.to_s.magenta]
          end
        end
      end

      def show_prettified_statistic(db, requested_quantity)
        rows = [[I18n.t('statistics.total_quantity').light_blue, db.to_s.magenta],
                [I18n.t('statistics.requests_quantity').light_blue, requested_quantity.to_s.magenta]]
        table = Terminal::Table.new title: I18n.t('statistics.statistic').light_yellow,
                                    headings: [I18n.t('statistics.title').cyan, I18n.t('statistics.number').cyan], rows: rows
        table.style = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }
        puts table
      end

      def exit?
        puts "\n#{I18n.t(:exit).cyan}"
        %w[y yes].include?(gets.chomp.downcase)
      end
    end
  end
end
