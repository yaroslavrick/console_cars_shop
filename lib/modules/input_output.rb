# frozen_string_literal: true

module Lib
  module Modules
    module InputOutput
      TABLE_STYLE = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }.freeze
      include FancyGets

      def user_input
        gets.chomp.strip
      end

      def user_input_with_asterisks
        gets_password.chomp.strip
      end

      def ask_option
        gets.chomp.to_i
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
