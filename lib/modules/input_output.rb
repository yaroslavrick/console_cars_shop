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

      def ask_option
        gets.chomp.to_i
      end

      def ask_field(rule)
        print colorize_text('main', localize('choose.please_choose')).to_s
        puts " #{colorize_text('option', localize("choose.#{rule}"))}:"
        user_input.downcase
      end

      def exit?
        puts "\n#{localize(:exit).cyan}"
        %w[y yes].include?(gets.chomp.downcase)
      end
    end
  end
end
