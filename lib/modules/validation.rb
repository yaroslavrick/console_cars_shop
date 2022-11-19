# frozen_string_literal: true

module Lib
  module Modules
    module Validation
      def field_less_then(from, to)
        return true if from.empty? || to.empty?

        from < to
      end
    end
  end
end
