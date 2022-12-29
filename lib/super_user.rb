# frozen_string_literal: true

module Lib
  class SuperUser
    include Lib::Modules::InputOutput
    include Lib::Modules::Colorize
    include Lib::Modules::Constants::ReadWriteType
    include Lib::Modules::Constants::FilePaths
    include Lib::Modules::Constants::RegExps
    include Lib::Modules::Constants::ParamsConst

    attr_reader :car_params, :admin_login_and_password, :params_validator, :cars_db, :cars_data, :id, :printer,
                :valid_status

    def initialize
      @cars_db = Lib::Models::DataBase.new
      @admin_login_and_password = Lib::Models::UsersDb.new.load_logins_and_passwords(ADMIN_FILE)[0]
      @params_validator = Lib::Validations::ParamsValidator.new
      @printer = Lib::PrintData.new
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
        printer.show_error_wrong_input
        Lib::WelcomeScreen.new.call
      end
    end

    def create_advertisement
      ask_car_params

      return unless valid_status

      add_advertisement
    end

    def update_advertisement
      @id = ask_id
      @cars_data = cars_db.load
      return printer.car_with_id_not_exists(id) unless find_car_by_id

      params = ask_car_params
      return unless valid_status

      update_data(params)
    end

    def delete_advertisement
      @id = ask_id
      @cars_data = cars_db.load
      return printer.car_with_id_not_exists(id) unless find_car_by_id

      delete_car_by_id
      save_car_to_db
      printer.car_deleted(id)
    end

    def log_out
      @welcome_screen = Lib::WelcomeScreen.new.log_out
      Lib::WelcomeScreen.new.call
    end

    private

    def update_data(params)
      update_car(params)
      save_car_to_db
      printer.car_updated(id)
    end

    def save_car_to_db
      cars_db.save(cars_data, WRITE, DB_FILE)
    end

    def delete_car_by_id
      cars_data.delete_if { |car| car['id'] == id }
    end

    def update_car(params)
      cars_data.map! do |car|
        car = replace_car_params(car, params) if car['id'] == id
        car
      end
    end

    def replace_car_params(car, params)
      CAR_PARAMS.each do |param|
        car[param.to_s] = INT_CAR_PARAMS.include?(param) ? params[param].to_i : params[param]
      end
      car
    end

    def find_car_by_id
      cars_data.any? { |car| car['id'] == id }
    end

    def ask_id
      printer.ask_id_message
      user_input
    end

    def ask_car_params
      @car_params = CAR_PARAMS.each_with_object({}) do |item, hash|
        if params_validator.validate_param(item, (field = ask_field(item)))
          hash[item] = field
        else
          puts colorize_text('error', params_validator.error_message)
          @valid_status = false
          break
        end
        @valid_status = true
      end
    end

    def add_advertisement
      cars_db.create_car(write_type: APPEND, filepath: DB_FILE, params: car_params)
      printer.show_car_created_message(cars_db.id)
    end
  end
end
