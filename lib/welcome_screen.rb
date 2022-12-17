# frozen_string_literal: true

module Lib
  class WelcomeScreen
    include Lib::Modules::Colorize
    include Lib::Modules::InputOutput

    MENU = %w[search_car show_all_cars help exit].freeze
    MENU_OPTIONS = [1, 2, 3, 4].freeze

    attr_reader :all_cars, :console

    def initialize
      @all_cars = Lib::Models::Cars.new
      @console = Lib::Console.new
    end

    def call
      greet
      show_options
      option = ask_option
      validate_option(option)
      run_option(option)
    end

    private

    def greet
      puts colorize_text('title', localize('main_menu.greet')).underline
    end

    def show_options
      MENU.each do |option|
        puts colorize_text('main', localize("main_menu.options.#{option}"))
      end
    end

    def run_option(option)
      case option
      when 1 then console.call
      when 2 then console.show_prettified_result(all_cars.load)
      when 3 then show_help_menu
      when 4 then exit
      end
      call
    end

    def validate_option(menu_option)
      return if MENU_OPTIONS.include?(menu_option)

      puts colorize_text('error', localize('main_menu.wrong_input'))
      call
    end

    def show_help_menu
      puts
      puts colorize_text('result', localize('main_menu.help_menu.search_car'))
      puts colorize_text('result', localize('main_menu.help_menu.show_all_cars'))
      puts colorize_text('result', localize('main_menu.help_menu.help'))
      puts colorize_text('result', localize('main_menu.help_menu.exit'))
      puts
      call
    end
  end
end
