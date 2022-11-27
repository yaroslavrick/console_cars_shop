# frozen_string_literal: true

module Lib
  module Modules
    module Colorize
      MAIN_COLOR = :light_blue
      OPTION_COLOR = :light_green
      TITLE_COLOR = :light_yellow
      HEADER_COLOR = :cyan
      RESULT_COLOR = :magenta
      ERROR_COLOR = :red

      def colorize_main(string)
        string.colorize(MAIN_COLOR)
      end

      def colorize_option(string)
        string.colorize(OPTION_COLOR)
      end

      def colorize_title(string)
        string.colorize(TITLE_COLOR)
      end

      def colorize_header(string)
        string.colorize(HEADER_COLOR)
      end

      def colorize_result(string)
        string.colorize(RESULT_COLOR)
      end

      def colorize_error(string)
        string.colorize(ERROR_COLOR)
      end
    end
  end
end
