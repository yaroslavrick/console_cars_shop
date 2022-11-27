# frozen_string_literal: true

module Lib
  class WelcomeScreen
    include Lib::Modules::Localization
    include Lib::Modules::Colorize
    include Lib::Modules::InputOutput

    attr_reader :all_cars, :console

    def initialize
      @all_cars = Lib::DataBase.new
      @console = Lib::Console.new
      ask_locale
      @exit = false
    end

    def call
      loop do
        greet
        show_options
        option = ask_option
        validate_option(option)
        run_option(option)
        break if @exit
      end
    end

    private

    def greet
      puts colorize_title(localize('main_menu.greet'))
    end

    def show_options
      puts colorize_main(localize('main_menu.options.search_car'))
      puts colorize_main(localize('main_menu.options.show_all_cars'))
      puts colorize_main(localize('main_menu.options.help'))
      puts colorize_main(localize('main_menu.options.exit'))
    end

    def run_option(option)
      case option
      when 1
        console.call
      when 2
        console.show_prettified_result(all_cars.load)
      when 3
        show_help_menu
      when 4
        @exit = true
      end
    end

    def validate_option(option)
      return if [1, 2, 3, 4].include?(option)

      puts colorize_error(localize('main_menu.wrong_input'))
      call
    end

    def show_help_menu
      puts
      puts colorize_result(localize('main_menu.help_menu.search_car'))
      puts colorize_result(localize('main_menu.help_menu.show_all_cars'))
      puts colorize_result(localize('main_menu.help_menu.help'))
      puts colorize_result(localize('main_menu.help_menu.exit'))
      puts
      call
    end
  end
end
