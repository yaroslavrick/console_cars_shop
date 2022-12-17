# frozen_string_literal: true

module Lib
  class WelcomeScreen
    include Lib::Modules::Colorize
    include Lib::Modules::InputOutput

    MENU_LOGGED = %w[my_searches log_out search_car show_all_cars help exit].freeze
    MENU_NOT_LOGGED = %w[log_in sign_up search_car show_all_cars help exit].freeze
    MENU_OPTIONS = [1, 2, 3, 4, 5, 6].freeze

    attr_reader :all_cars, :console, :user, :logged, :printer

    def initialize
      @all_cars = Lib::Models::Cars.new
      @console = Lib::Console.new
      @user = Lib::Authentication.new
      @printer = Lib::PrintData.new
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
      return transform_option(MENU_LOGGED) if user.auth_status

      transform_option(MENU_NOT_LOGGED)
    end

    def transform_option(menu)
      number = 1
      menu.each do |option|
        puts colorize_text('main', "#{number}. #{localize("main_menu.options.#{option}")}")
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
      when 1 then show_user_searches
      when 2 then log_out
      when 3..6 then main_option(option)
      end
    end

    def run_not_logged_option(option)
      case option
      when 1 then user.log_in
      when 2 then user.sign_up
      when 3..6 then main_option(option)
      end
    end

    def main_option(option)
      case option
      when 3 then run_search_engine
      when 4 then show_result
      when 5 then show_help_menu
      when 6 then exit
      end
    end

    def show_user_searches
      @user_searches = Lib::Models::UserSearches.new(email: user.email).show_searches
    end

    def run_search_engine
      console.call(status: user.auth_status, email: user.email)
    end

    def show_result
      console.show_prettified_result(all_cars.load)
    end

    def validate_option(menu_option)
      return if MENU_OPTIONS.include?(menu_option)

      printer.show_error_wrong_input
      call
    end

    def show_help_menu
      if user.auth_status
        help_menu_printer(MENU_LOGGED)
      else
        help_menu_printer(MENU_NOT_LOGGED)
      end
      puts
      call
    end

    def help_menu_printer(param)
      param.each do |option|
        puts colorize_text('result', localize("main_menu.help_menu.#{option}"))
      end
    end

    def log_out
      user.auth_status = false
      puts "\n#{colorize_text('result', localize('main_menu.log_out.good_bye'))}"
    end
  end
end
