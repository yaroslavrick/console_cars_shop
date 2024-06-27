# frozen_string_literal: true

module Lib
  class SuperUser
    include Lib::Modules::Constants::FilePaths
    attr_reader :advertisement, :printer, :admin_login_and_password

    def initialize
      @advertisement = Lib::Models::Advertisement.new
      @printer = Lib::PrintData.new
      @admin_login_and_password = Lib::Models::UsersDb.new.load_logins_and_passwords(ADMIN_FILE)[0]
    end

    def check_for_superuser(email:, password:)
      admin_login_and_password[:email] == email && admin_login_and_password[:password] == password
    end

    def run_admin_option(option)
      case option
      when 1 then advertisement.create
      when 2 then advertisement.update
      when 3 then advertisement.delete
      when 4 then log_out
      else
        printer.show_error_wrong_input
        Lib::WelcomeScreen.new.call
      end
    end

    def log_out
      Lib::WelcomeScreen.new.log_out
      Lib::WelcomeScreen.new.call
    end
  end
end
