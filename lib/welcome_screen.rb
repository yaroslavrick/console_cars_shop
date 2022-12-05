# frozen_string_literal: true

module Lib
  class WelcomeScreen
    include Lib::Modules::Localization
    include Lib::Modules::Colorize
    include Lib::Modules::InputOutput

    MENU_LOGGED = %w[log_out search_car show_all_cars help exit].freeze
    MENU_OPTIONS_LOGGED = [1, 2, 3, 4, 5].freeze

    MENU_NOT_LOGGED = %w[log_in sign_up search_car show_all_cars help exit].freeze
    MENU_OPTIONS_NOT_LOGGED = [1, 2, 3, 4, 5, 6].freeze

    HELP_MENU = %w[search_car show_all_cars help exit].freeze

    attr_reader :all_cars, :console, :user, :logged

    def initialize
      @all_cars = Lib::Models::Cars.new
      @console = Lib::Console.new
      @user = Lib::Authentication.new
      ask_locale
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
      puts colorize_title(localize('main_menu.greet'))
    end

    def show_options
      if user.auth_status
        transform_option(MENU_LOGGED)
      else
        transform_option(MENU_NOT_LOGGED)
      end
    end

    def transform_option(menu)
      number = 1
      menu.each do |option|
        puts colorize_main("#{number}. #{localize("main_menu.options.#{option}")}")
        number += 1
      end
    end

    def run_option(option)
      if user.auth_status
        run_logged_option(option)
      else
        run_not_logged_option(option)
      end
      call
    end

    def run_logged_option(option)
      case option
      when 1 then log_out
      when 2 then console.call
      when 3 then console.show_prettified_result(all_cars.load)
      when 4 then show_help_menu
      when 5 then exit
      end
    end

    def run_not_logged_option(option)
      case option
      when 1 then log_in
      when 2 then sign_up
      when 3 then console.call
      when 4 then console.show_prettified_result(all_cars.load)
      when 5 then show_help_menu
      when 6 then exit
      end
    end

    def validate_option(menu_option)
      if user.auth_status
        return if MENU_OPTIONS_LOGGED.include?(menu_option)
      elsif MENU_OPTIONS_NOT_LOGGED.include?(menu_option)
        return
      end

      puts colorize_error(localize('main_menu.wrong_input'))
      call
    end

    def show_help_menu
      puts
      HELP_MENU.each do |option|
        puts colorize_result(localize("main_menu.help_menu.#{option}"))
      end
      puts
      call
    end

    def log_in
      user.log_in
      call
    end

    def sign_up
      user.sign_up
      call
    end

    def log_out
      user.auth_status = false
      puts
      puts colorize_result(localize('main_menu.log_out.good_bye'))
    end
  end
end
