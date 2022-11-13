# frozen_string_literal: true

require 'yaml'
require 'date'
require 'bundler/setup'
require 'terminal-table'
require 'colorize'
require 'i18n'

require_relative './modules/database'
require_relative './modules/input_output'
require_relative './modules/search_engine'
require_relative './modules/statistics'
require_relative './classes/cars_management'
