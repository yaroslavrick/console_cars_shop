module Lib
  class SuperUser
    include Lib::Modules::InputOutput
    include Lib::Modules::Colorize
    include Lib::Modules::Constants::ReadWriteType
    include Lib::Modules::Constants::FilePaths
    include Lib::Modules::Constants::RegExps

    CAR_PARAMS = %i[make model year odometer price description].freeze

    attr_reader :car_params, :su_status, :admin_login_and_password, :params_validator, :cars_db

    def initialize
      @su_status = false
      @cars_db = Lib::Models::DataBase.new
      @admin_login_and_password = Lib::Models::UsersDb.new.load_logins_and_passwords(ADMIN_FILE)[0]
      @params_validator = Lib::Models::ParamsValidator.new
    end

    def check_for_superuser(email:, password:)
      @admin_login_and_password[:email] == email && @admin_login_and_password[:password] == password
    end

    def run_admin_option(option)
      case option
      when 1 then create_advertisement
      when 2 then update_advertisement
      when 3 then delete_advertisement
      when 4 then log_out
      else
        puts colorize_text('error', localize('main_menu.wrong_input'))
        puts 'Wrong input!'
        Lib::WelcomeScreen.new.call
      end
    end

    def create_advertisement
      ask_car_params
      params_validator.validate_car_params(car_params) ? add_advertisement : show_invalid_value_error
    end

    def update_advertisement
      # todo
    end

    def delete_advertisement
      # todo
    end

    def log_out
      @welcome_screen = Lib::WelcomeScreen.new.log_out
      Lib::WelcomeScreen.new.call
    end

    private

    def ask_car_params
      initialize_car_params
      @car_params = CAR_PARAMS.each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
    end

    def initialize_car_params
      @car_params = {
        # make: {},
        # model: {},
        # year: {},
        # odometer: {},
        # price: {},
        # description: {}
      }
    end

    def add_advertisement
      cars_db.create_car(write_type: APPEND, filepath: DB_FILE, params: car_params)
    end
  end
end
