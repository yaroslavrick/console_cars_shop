# frozen_string_literal: true

require 'bcrypt'
module Lib
  class Authentication
    include Lib::Modules::InputOutput
    include Lib::Modules::Localization
    include Lib::Modules::Colorize

    attr_reader :email, :password, :logins_and_passwords_db, :user
    attr_accessor :auth_status

    def initialize
      @user = Lib::Models::UsersDb.new
      @logins_and_passwords_db = @user.load_logins_and_passwords
    end

    def log_in
      ask_user_log_in_data
      validate_log_in_data
    end

    def sign_up
      data = ask_user_sign_up_data
      return unless validate_sign_up_data

      @auth_status = true
      add_user_to_dp(data)
    end

    private

    def ask_user_log_in_data
      @email = ask_user_email
      @password = ask_user_password
      { email: email, password: @password }
    end

    def ask_user_sign_up_data
      show_tip_for_email
      @email = ask_user_email
      show_tips_for_password
      @password = ask_user_password
      encrypted_password = BCrypt::Password.create(@password)
      { email: email, password: encrypted_password }
    end

    def ask_user_email
      show_message_for_email
      user_input
    end

    def show_message_for_email
      puts colorize_option(localize('authentication.enter_email'))
    end

    def show_tip_for_email
      puts colorize_result(localize('authentication.tip.tip_message'))
      puts colorize_result(localize('authentication.tip.email.format'))
      puts colorize_result(localize('authentication.tip.email.number_of_symbols_before_at'))
      puts colorize_result(localize('authentication.tip.email.unique'))
    end

    def ask_user_password
      show_message_for_password
      user_input
    end

    def show_message_for_password
      puts colorize_option(localize('authentication.enter_password'))
    end

    def show_tips_for_password
      puts colorize_result(localize('authentication.tip.tip_message'))
      puts colorize_result(localize('authentication.tip.password.capital_letters'))
      puts colorize_result(localize('authentication.tip.password.special_characters'))
      puts colorize_result(localize('authentication.tip.password.number_of_symbols_min'))
      puts colorize_result(localize('authentication.tip.password.number_of_symbols_max'))
    end

    def validate_log_in_data
      if @user.load_logins_and_passwords.any? { |user| user[:email] == email && user[:password] == password }
        @auth_status = true
        hello_message
      else
        puts colorize_error(localize('authentication.email_not_exists'))
      end
    end

    def validate_sign_up_data
      validate_email && validate_password && compare_sign_in_and_db
    end

    def validate_email
      return true if validate_email_type_format && validate_email_length_before_at && validate_email_unique

      puts colorize_error(localize('authentication.email_not_valid'))
    end

    def validate_email_type_format
      email.match?(URI::MailTo::EMAIL_REGEXP)
    end

    def validate_email_length_before_at
      email.split('@').first.length >= 5
    end

    def validate_email_unique
      @user.load_logins_and_passwords.none? { |car| car[:email] == email }
    end

    def validate_password
      valid_password_regexp = /^(?=.*[A-Z])(?=(.*[@$!%*#?&]){2}).{8,20}$/
      return true if password.match?(valid_password_regexp)

      puts colorize_error(localize('authentication.password_not_valid'))
    end

    def compare_sign_in_and_db
      return true if validate_email_unique

      puts "\n#{colorize_error(localize('authentication.already_exists'))}"
    end

    def add_user_to_dp(data)
      user.add_new_user(data)
      hello_message
    end

    def hello_message
      puts "\n#{colorize_main(localize('authentication.hello_message'))}#{colorize_result(email)}!"
    end
  end
end
