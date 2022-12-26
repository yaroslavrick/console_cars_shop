# frozen_string_literal: true

module Lib
  module Modules
    module Constants
      module ReadWriteType
        WRITE = 'w'
        WRITE_PLUS = 'w+'
        APPEND_PLUS = 'a+'
        APPEND = 'a'
      end

      module FilePaths
        CURRENT_PATH = File.dirname(__FILE__)
        LOG_FILE = File.join(CURRENT_PATH, '../db/searches.yml').freeze
        USERS_LOGINS_AND_PASSWORDS_FILE = File.join(CURRENT_PATH, '../db/users.yml').freeze
        USER_SEARCHES_FILE = File.join(CURRENT_PATH, '../db/user_searches.yml').freeze
        DB_FILE = File.join(CURRENT_PATH, '../db/db.yml').freeze
        ADMIN_FILE = File.join(CURRENT_PATH, '../db/admin.yml').freeze
      end

      module RegExps
        VALID_PASSWORD_REGEXP = /^(?=.*[A-Z])(?=(.*[@$!%*#?&]){2}).{8,20}$/
        MODEL_AND_MAKE_REGEXP = /^[a-zA-Z0-9\s]{3,50}$/
        INTEGER_REGEXP = /^\d{0,}$/
      end

      module Options
        SEARCH_RULES_OPTIONS = %i[make model year_from year_to price_from price_to].freeze
      end

      module PrintConst
        TABLE_STYLE = { all_separators: true, padding_left: 2, padding_right: 2, border: :unicode_thick_edge }.freeze
      end

      module DateConst
        DATE_FORMAT = '%d/%m/%Y'
      end

      module MenuConst
        MENU_LOGGED = %w[my_searches log_out search_car show_all_cars help exit].freeze
        MENU_NOT_LOGGED = %w[log_in sign_up search_car show_all_cars help exit].freeze
        MENU_SUPERUSER = %w[create_advertisement update_advertisement delete_advertisement log_out].freeze
      end

      module ColorizeConst
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
      end

      module ParamsConst
        MIN_YEAR = 1900
        MAX_DESCRIPTION_LENGTH = 5000
        CAR_PARAMS = %i[make model year odometer price description].freeze
      end
    end
  end
end
