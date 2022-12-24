# frozen_string_literal: true

module Lib
  class Authentication
    include Lib::Modules::InputOutput
    include Lib::Modules::Colorize
    include Lib::Modules::Validation
    include Lib::Modules::Constants::ReadWriteType
    include Lib::Modules::Constants::FilePaths
    include Lib::Modules::Constants::RegExps

    attr_reader :email, :password, :logins_and_passwords_db, :user, :tips, :superuser_status
    attr_accessor :auth_status

    def initialize
      @user = Lib::Models::UsersDb.new
      @logins_and_passwords_db = @user.load_logins_and_passwords
      @tips = Lib::Tips.new
      @admin = Lib::SuperUser.new
    end

    def log_in
      ask_user_log_in_data
      admin?
      validate_log_in_data
    end

    def sign_up
      data = [ask_user_sign_up_data]
      return unless validate_sign_up_data

      @auth_status = true
      add_user_to_dp(data)
    end

    private

    def admin?
      @superuser_status = @admin.check_for_superuser(email: email, password: password)
      @superuser_status
    end

    def ask_user_log_in_data
      @email = ask_user_email.downcase
      @password = ask_user_password
      { email: email, password: password }
    end

    def ask_user_sign_up_data
      tips.show_tips_for_email
      @email = ask_user_email
      tips.show_tips_for_password
      @password = ask_user_password
      encrypted_password = BCrypt::Password.create(password)
      { email: email, password: encrypted_password }
    end

    def ask_user_email
      show_message_for_email
      user_input
    end

    def show_message_for_email
      puts colorize_text('option', localize('authentication.enter_email'))
    end

    def ask_user_password
      show_message_for_password
      user_input_with_asterisks
    end

    def show_message_for_password
      puts colorize_text('option', localize('authentication.enter_password'))
    end

    def validate_log_in_data
      if @user.load_logins_and_passwords.any? { |user| user[:email] == email && user[:password] == password }
        @auth_status = true
        hello_message
      elsif superuser_status
        hello_message
      else
        puts colorize_text('error', localize('authentication.email_not_exists'))
      end
    end

    def validate_sign_up_data
      validate_email && validate_password && compare_sign_in_and_db
    end

    def validate_email
      return true if validate_email_type_format && validate_email_length_before_at && validate_email_unique

      puts colorize_text('error', localize('authentication.email_not_valid'))
    end

    def validate_email_unique
      @user.load_logins_and_passwords.none? { |user| user[:email] == email }
    end

    def validate_password
      return true if password.match?(VALID_PASSWORD_REGEXP)

      puts colorize_text('error', localize('authentication.password_not_valid'))
    end

    def compare_sign_in_and_db
      return true if validate_email_unique

      puts "\n#{colorize_text('error', localize('authentication.already_exists'))}"
    end

    def add_user_to_dp(data)
      user.save(data, APPEND, USERS_LOGINS_AND_PASSWORDS_FILE)
      hello_message
    end

    def hello_message
      puts "\n#{colorize_text('main', localize('authentication.hello_message'))}#{colorize_text('result', email)}!"
    end
  end
end
