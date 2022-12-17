# frozen_string_literal: true

module Lib
  module Modules
    module InputOutput
      def localize(key)
        I18n.t(key)
      end

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
