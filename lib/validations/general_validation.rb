# frozen_string_literal: true

module Lib
  module Validations
    class GeneralValidation
      include Lib::Modules::Constants::RegExps
      include Lib::Modules::Constants::ParamsConst

      def check_for_length(value)
        if value.match?(MODEL_AND_MAKE_REGEXP)
          true
        else
          @error_message = I18n.t('admin_panel.validation.min_length')
          false
        end
      end

      def check_for_english_letters_only(value)
        if value.match?(ONLY_ENGLISH_LETTERS_REGEX)
          true
        else
          @error_message = I18n.t('admin_panel.validation.english_only')
          false
        end
      end

      def check_for_empty_value(value)
        if value.empty?
          @error_message = I18n.t('admin_panel.validation.required_param')
          false
        else
          true
        end
      end

      def check_for_integers(value)
        if value.match?(INTEGER_REGEXP)
          true
        else
          @error_message = I18n.t('admin_panel.validation.integer_param')
          false
        end
      end

      def not_greater_than_current_year(value)
        if value.to_i <= Date.today.year
          true
        else
          @error_message = I18n.t('admin_panel.validation.greater_than_current_year')
          false
        end
      end

      def greater_than_min_year(value)
        if value.to_i >= MIN_YEAR
          true
        else
          @error_message = I18n.t('admin_panel.validation.greater_than_min_year', min_year: MIN_YEAR)
          false
        end
      end

      def greater_or_equal_to_zero(value)
        if value.to_i >= 0
          true
        else
          @error_message = I18n.t('admin_panel.validation.greater_or_equal_to_zero')
          false
        end
      end

      def check_for_strings(value)
        if value.is_a?(String)
          true
        else
          @error_message = I18n.t('admin_panel.validation.description_string')
          false
        end
      end

      def check_for_max_length(value)
        if value.length <= MAX_DESCRIPTION_LENGTH
          true
        else
          @error_message = I18n.t(
            'admin_panel.validation.description_max_length', MAX_DESCRIPTION_LENGTH: MAX_DESCRIPTION_LENGTH
          )
          false
        end
      end
    end
  end
end
