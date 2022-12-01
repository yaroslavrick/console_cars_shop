# frozen_string_literal: true

module Lib
  class Authentication
    include Lib::Modules::InputOutput
    include Lib::Modules::Localization
    include Lib::Modules::Colorize

    attr_reader :email, :password, :logins_and_passwords_db, :user

    def initialize
      @user = DataBase.new
      @logins_and_passwords_db = @user.load_logins_and_passwords
    end

    def log_in
      ask_user_log_data
      validate_log_in_data
    end

    def sign_up
      data = ask_user_log_data

      add_user_to_dp(data) if validate_sign_up_data
    end

    private

    def ask_user_log_data
      @email = ask_user_email
      @password = ask_user_password
      { email: email, password: BCrypt::Password.create(password) }
    end

    def ask_user_email
      puts colorize_option(localize('authentication.enter_email'))
      user_input
    end

    def ask_user_password
      puts colorize_option(localize('authentication.enter_password'))
      # AZ%?azassaddwfwvevs2
      user_input
    end

    def validate_log_in_data
      if logins_and_passwords_db.any? { |car| car[:email] == email && car[:password] == password }
        hello_message
      else
        puts colorize_error(localize('authentication.email_not_exists'))
      end
    end

    def validate_sign_up_data
      validate_email && validate_password && compare_sign_in_and_db
    end

    def validate_email
      # o Should have email-type format
      # o Should have at least 5 symbols before @
      # o Should be unique
      # validate_email_type_format
      # validate_email_length_before_at
      # validate_email_unique

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
      logins_and_passwords_db.none? { |car| car[:email] == email }
    end

    def validate_password
      # Password
      # o Should have at least 1 capital letter ^(.*?[A-Z]){1,}.*$ OR: (?=.*?[A-Z])
      # o Should have at least 2 special characters ((?:[^`!@#$%^&*\-_=+'\/.,]*[`!@#$%^&*\-_=+'\/.,]){2})
      # o Should be at least 8 symbols (.{8,20})
      # o Should be no more than 20 symbols (.{8,20})

      valid_password_regexp = /^(?=.*[A-Z])(?=(.*[@$!%*#?&]){2}).{8,20}$/

      return true if password.match?(valid_password_regexp)

      # puts "\nPassword is not valid"
      puts colorize_error(localize('authentication.password_not_valid'))
      # Lib::WelcomeScreen.new.call
    end

    def compare_sign_in_and_db
      #       If user with such email already exists – - he should see the error message
      # and see the main menu right after that (see Validations)
      # return unless logins_and_passwords_db[:user_email].include?(email)

      return true if validate_email_unique

      puts "\n#{colorize_error(localize('authentication.already_exists'))}"
      # Lib::WelcomeScreen.new.call
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
