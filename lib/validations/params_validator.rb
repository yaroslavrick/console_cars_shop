# frozen_string_literal: true

module Lib
  module Validations
    class ParamsValidator < GeneralValidation
      attr_reader :printer, :error_message

      def initialize
        @printer = Lib::PrintData.new
        @error_message = ''
      end

      def validate_param(key, value)
        case key
        when :make, :model then validate_make_and_model(value)
        when :year then validate_year(value)
        when :odometer then validate_odometer(value)
        when :price then validate_price(value)
        when :description then validate_description(value)
        end
      end

      private

      def validate_make_and_model(value)
        return false unless check_for_empty_value(value)

        return false unless check_for_english_letters_only(value)

        check_for_length(value)
      end

      def validate_year(value)
        return false unless check_for_empty_value(value)

        check_for_integers(value) && not_greater_than_current_year(value) && greater_than_min_year(value)
      end

      def validate_odometer(value)
        return false unless check_for_empty_value(value)

        check_for_integers(value) && greater_or_equal_to_zero(value)
      end

      def validate_price(value)
        return false unless check_for_empty_value(value)

        check_for_integers(value) && greater_or_equal_to_zero(value)
      end

      def validate_description(value)
        check_for_strings(value) && check_for_max_length(value)
      end
    end
  end
end
