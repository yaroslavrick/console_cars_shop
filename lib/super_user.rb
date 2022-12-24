require_relative './models/users_db.rb'
module Lib
  class SuperUser
    include Lib::Modules::Constants::ReadWriteType
    include Lib::Modules::Constants::FilePaths
    include Lib::Modules::Constants::RegExps

    CAR_PARAMS= %i[make model year odometer price description].freeze

    def initialize
      @su_status = false
      @db = Lib::Models::DataBase.new
      @admin_data = Lib::Models::UsersDb.new.load_logins_and_passwords(ADMIN_FILE)[0]
    end

    def check_for_superuser(email:, password:)
      @admin_data[:email] == email && @admin_data[:password] == password
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

    end

    def update_advertisement
      # todo
    end

    def delete_advertisement
      # todo
    end

    def log_out
      @welcome_screen = Lib::WelcomeScreen.new.log_out
      @welcome_screen.call
    end

    private

    def ask_car_params
      initialize_car_params
      car_params = CAR_OPTIONS.each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end


      make = user_input
      model = user_input
      validate_make_and_model
      year = user_input
      validate_year
      odometer = user_input.to_i
      price = user_input.to_i
      validate_odometer_and_price
      description = user_input
      validate_description
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
  end
end
