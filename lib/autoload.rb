# frozen_string_literal: true

require 'yaml'
require 'date'
require 'bundler/setup'
require 'terminal-table'
require 'colorize'
require 'i18n'
require 'uri'
require 'bcrypt'
require 'ffaker'
require 'fancy_gets'
require 'pry'

require_relative '../config/localization/i18n'
require_relative './modules/constants'
require_relative './modules/input_output'
require_relative './modules/validation'
require_relative './modules/colorize'
require_relative '../config/locale_setter'
require_relative './print_data'
require_relative './models/database'
require_relative './models/statistics'
require_relative './models/users_db'
require_relative './models/user_searches'
require_relative './models/params_validator'
require_relative './super_user'
require_relative './search_engine_query'
require_relative './tips'
require_relative './console'
require_relative './welcome_screen'
require_relative './authentication'
