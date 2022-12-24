module Lib
  module Models
    class ParamsValidator
      MODEL_AND_MAKE_REGEXP = /^[a-zA-Z0-9]{3,50}$/
      INTEGER_REGEXP = /^\d{0,}$/
      MIN_YEAR = 1900
      MAX_DESCRIPTION_LENGTH = 5000

      def validate_car_params(car_params)
        car_params.each do |key, value|
          case key
          when :make || :model then validate_make_and_model(value)
          when :year then validate_year(value)
          when :odometer then validate_odometer(value)
          when :price then validate_price(value)
          when :description then validate_description(value)
          end
        end
      end

      private

      def validate_make_and_model(value)
        # o Required
        # o Should have at least 3 symbols and have specified validation
        # message
        # o Should have at most 50 symbols and have specified validation
        # message
        # o Should consists only of English letters and have specified validation
        # message
        return false if value.empty?

        value.match?(MODEL_AND_MAKE_REGEXP)
      end

      def validate_year(value)
        # o Required
        # o Should be an integer and have specified validation message
        # o Should be not greater than current year and have specified
        # validation message
        # o Should be greater than 1900 year and have specified validation
        # message
        return false if value.empty?

        check_for_integers(value) && value <= Date.today.year && value >= MIN_YEAR
      end

      def validate_odometer(value)
        # o Required
        # o Should be an integer and have specified validation message
        # o Should be >= 0 and have specified validation message
        return false if value.empty?

        check_for_integers(value) && greater_or_equal_to_zero(value)
      end

      def validate_price(value)
        # o Required
        # o Should be an integer and have specified validation message
        # o Should be >= 0 and have specified validation message
        return false if value.empty?

        check_for_integers(value) && greater_or_equal_to_zero(value)
      end

      def validate_description(value)
        # o Optional
        # o Should be a String and have specified validation message
        # o Should have no more than 5000 symbols and have specified
        # validation message
        check_for_strings(value) && check_for_max_length(value)
      end

      def check_for_integers(value)
        value.match?(INTEGER_REGEXP)
      end

      def greater_or_equal_to_zero(value)
        value >= 0
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