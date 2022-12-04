module Lib
  module Modules
    module Validation
      def field_less_then(from, to)
        return true if from.empty? || to.empty?

        from.to_i < to.to_i
      end
    end
  end
end
