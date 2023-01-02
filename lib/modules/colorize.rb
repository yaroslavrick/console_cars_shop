# frozen_string_literal: true

module Lib
  module Modules
    module Colorize
      include Lib::Modules::Constants::ColorizeConst

      def colorize_text(type, string)
        string.colorize(TYPES[type])
      end
    end
  end
end
