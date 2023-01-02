# frozen_string_literal: true

require_relative 'lib/autoload'

Config::LocaleSetter.new.call
Lib::WelcomeScreen.new.call
