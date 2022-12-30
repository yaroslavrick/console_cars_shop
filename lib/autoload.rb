# frozen_string_literal: true

require 'yaml'
require 'date'
require 'bundler/setup'
require 'terminal-table'
require 'colorize'
require 'i18n'

require_relative './modules/input_output'
require_relative './modules/validation'
require_relative './modules/colorize'
require_relative '../config/locale_setter'
require_relative './print_data'
require_relative './models/database'
require_relative './models/cars'
require_relative './models/statistics'
require_relative './search_engine_query'
require_relative './console'
