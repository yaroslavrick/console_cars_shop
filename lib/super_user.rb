module Lib
  class SuperUser
    include Lib::Modules::InputOutput
    include Lib::Modules::Colorize
    include Lib::Modules::Constants::ReadWriteType
    include Lib::Modules::Constants::FilePaths
    include Lib::Modules::Constants::RegExps

    CAR_PARAMS = %i[make model year odometer price description].freeze

    attr_reader :car_params, :su_status, :admin_login_and_password, :params_validator, :cars_db, :cars_data

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
        Lib::WelcomeScreen.new.call
      end
    end

    def create_advertisement
      ask_car_params
      params_validator.validate_car_params(car_params) ? add_advertisement : show_invalid_value_error
    end

    def update_advertisement
      # • If admin user chooses “Updated an advertisement” he should be asked to enter
      #   the id of the updatable advertisement and then should be asked to enter all the
      #   values needed for advertisement updating
      #   o If all the values are correct (see Validation section) - the advertisement
      #   should be updated in the database and admin should see “You have
      #   successfully updated the car with id ADVERTISEMENT_ID!” and see the
      #   main Admin menu right after that.
      #   o If some values are not correct (see Validation section) - the advertisement
      #   should not be updated in the database and admin should see the
      #   validation errors and see the main Admin menu right after that.

      id = ask_id
      params = ask_car_params
      @cars_data = cars_db.load
      update_car(params, id) if find_car_by_id(id: id)
      cars_db.save(cars_data, WRITE, DB_FILE)
    end

    def delete_advertisement
      # todo
    end

    def log_out
      @welcome_screen = Lib::WelcomeScreen.new.log_out
      Lib::WelcomeScreen.new.call
    end

    private

    def update_car(params, id)
      cars_data.map! do |car|
        if (car['id'] == id)
          car = replace_car_params(car, params)
        end
        car
      end
    end

    def replace_car_params(car, params)
      CAR_PARAMS.each do |param|
        car[param.to_s] = params[param].capitalize
      end
      car
    end

    def find_car_by_id(id:)
      result = nil
      cars_data.each do |car|
        if (car['id'] == id)
          result = car
        end
      end
      result
    end

    def ask_id
      puts "Enter the id:"
      user_input
    end

    def ask_car_params
      initialize_car_params
      @car_params = CAR_PARAMS.each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
    end

    def initialize_car_params
      @car_params = {}
    end

    def add_advertisement
      cars_db.create_car(write_type: APPEND, filepath: DB_FILE, params: car_params)
    end
  end
end
