# frozen_string_literal: true

module Lib
  module Models
    class ParamsValidator
      include Lib::Modules::Constants::DateConst
      include Lib::Modules::Constants::ReadWriteType
      include Lib::Modules::Constants::FilePaths
      include Lib::Modules::Constants::RegExps
      include Lib::Modules::Constants::ParamsConst

      attr_reader :printer, :validations_result

      def initialize
        @printer = Lib::PrintData.new
      end

      def validate_car_params(car_params)
        @validations_result = []
        car_params.each do |key, value|
          validations_result.push(validate_param(key, value))
        end
        validations_result.all?(true)
      end

      def print_errors
        validations_result.each_with_index do |value, index|
          next if value

          CAR_PARAMS.each_with_index do |param, idx|
            printer.wrong_parameter(param) if idx == index
          end
        end
      end

      private

      def validate_param(key, value)
        case key
        when :make, :model then validate_make_and_model(value)
        when :year then validate_year(value)
        when :odometer then validate_odometer(value)
        when :price then validate_price(value)
        when :description then validate_description(value)
        end
      end

      def validate_make_and_model(value)
        return false if value.empty?

        value.match?(MODEL_AND_MAKE_REGEXP)
      end

      def validate_year(value)
        return false if value.empty?

        check_for_integers(value) && value.to_i <= Date.today.year && value.to_i >= MIN_YEAR
      end

      def validate_odometer(value)
        return false if value.empty?

        check_for_integers(value) && greater_or_equal_to_zero(value)
      end

      def validate_price(value)
        return false if value.empty?

        check_for_integers(value) && greater_or_equal_to_zero(value)
      end

      def validate_description(value)
        check_for_strings(value) && check_for_max_length(value)
      end

      def check_for_integers(value)
        value.match?(INTEGER_REGEXP)
      end

      def greater_or_equal_to_zero(value)
        value.to_i >= 0
      end

      def check_for_strings(value)
        value.is_a?(String)
      end

      def check_for_max_length(value)
        value.length <= MAX_DESCRIPTION_LENGTH
      end
    end
  end
end
