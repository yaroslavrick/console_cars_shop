module Lib
  module Modules
    module Validation
      def validation_for_emptiness?(rules)
        rules.empty?
      end

      def validation_for_both_zero_values?(rule_from, rule_to)
        rule_from.zero? && rule_to.zero?
      end
    end
  end
end
