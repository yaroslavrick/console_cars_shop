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

      def exit?
        puts "\n#{localize(:exit).cyan}"
        %w[y yes].include?(gets.chomp.downcase)
      end
    end
  end
end
