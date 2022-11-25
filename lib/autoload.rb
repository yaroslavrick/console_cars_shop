# frozen_string_literal: true

require 'yaml'
require 'date'
require 'bundler/setup'
require 'terminal-table'
require 'colorize'
require 'i18n'

require_relative './database'
require_relative './modules/input_output'
require_relative './search_engine_query'
require_relative './statistics'
require_relative './modules/validation'
require_relative './modules/localization'
require_relative './modules/colorize'
require_relative './console'
