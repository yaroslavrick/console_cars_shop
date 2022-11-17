module Lib
  module Modules
    module Validation
      def field_less_then(from, to)
        return true if from.empty? || to.empty?

        from < to
      end

      def validate_user_input?(params)
        fields_valid = field_less_then(params[:year_from],
                                       params[:year_to]) && field_less_then(params[:price_from],
                                                                            params[:price_to])
        puts 'You entered wrong field' unless fields_valid

        fields_valid
      end
    end
  end
end
