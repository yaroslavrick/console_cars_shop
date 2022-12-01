# frozen_string_literal: true

module Lib
  class WelcomeScreen
    include Lib::Modules::Localization
    include Lib::Modules::Colorize
    include Lib::Modules::InputOutput

    MENU = %w[log_in sign_up log_out search_car show_all_cars help exit].freeze
    MENU_OPTIONS = [1, 2, 3, 4, 5, 6, 7].freeze
    HELP_MENU = %w[search_car show_all_cars help exit].freeze
    # RUN_OPTIONS = {
    #   1: log_in,
    #   2: sign_up,
    #   3: log_out,
    #   4: console.call,
    #   5: console.show_prettified_result(all_cars.load),
    #   6: show_help_menu,
    #   7: exit?
    # }

    attr_reader :all_cars, :console, :user

    def initialize
      @all_cars = Lib::DataBase.new
      @console = Lib::Console.new
      @user = Lib::Authentication.new
      ask_locale
      @logged = false
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
      number = 1
      MENU.each do |option|
        puts colorize_main("#{number}. #{localize("main_menu.options.#{option}")}")
        number += 1
      end
    end

    # def run_option(option)
    #   # RUN_OPTIONS[option]
    #   case option
    #   when 1 then log_in
    #   when 2 then sign_up
    #   when 3 then log_out
    #   when 4 then console.call
    #   when 5 then console.show_prettified_result(all_cars.load)
    #   when 6 then show_help_menu
    #   when 7 then exit
    #   end
    #   call
    # end

    def validate_option(menu_option)
      return if MENU_OPTIONS.include?(menu_option)

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
      puts
      puts colorize_result(localize('main_menu.log_out.good_bye'))
    end
  end
end
