# frozen_string_literal: true

module Lib
  module Modules
    module Validation
      def field_less_then(from, to)
        return true if from.empty? || to.empty?

        from.to_i < to.to_i
      end

      def validate_email_type_format
        email.match?(URI::MailTo::EMAIL_REGEXP)
      end

      def validate_email_length_before_at
        email.split('@').first.length >= 5
      end
    end
  end
end
