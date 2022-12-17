# frozen_string_literal: true

module Lib
  module Modules
    module Colorize
      MAIN_COLOR = :light_blue
      OPTION_COLOR = :light_green
      TITLE_COLOR = :light_yellow
      HEADER_COLOR = :cyan
      RESULT_COLOR = :magenta
      ERROR_COLOR = :blue
      TYPES = {
        'main' => MAIN_COLOR,
        'option' => OPTION_COLOR,
        'title' => TITLE_COLOR,
        'header' => HEADER_COLOR,
        'result' => RESULT_COLOR,
        'error' => ERROR_COLOR
      }.freeze

      def colorize_text(type, string)
        string.colorize(TYPES[type])
      end
    end
  end
end
