# frozen_string_literal: true

require 'yaml'
require 'ffaker'
require 'faker'
require 'date'
require_relative './lib/models/database'

WRITE = 'w'
APPEND = 'a'
CURRENT_PATH = File.dirname(__FILE__)
PATH_TO_DB = File.join(CURRENT_PATH, './lib/db/db.yml')
PATH_TO_DB_BACKUP = File.join(CURRENT_PATH, './lib/db/db_backup.yml')

namespace :work_with_database do
  desc 'Clear whole database'
  task :clear_whole_database do
    db = Lib::Models::DataBase.new(PATH_TO_DB)
    db.save(nil, WRITE, PATH_TO_DB)
  end

  desc 'Restore database'
  task :restore_database do
    db = Lib::Models::DataBase.new(PATH_TO_DB_BACKUP)
    backup = db.load(PATH_TO_DB_BACKUP)
    db.save(backup, WRITE, PATH_TO_DB)
  end
end

namespace :add_to_database do
  desc 'Add a car to database'
  task :add_car do
    db = Lib::Models::DataBase.new(PATH_TO_DB)
    db.create_car(APPEND, PATH_TO_DB)
  end

  desc 'Add cars to database'
  task :add_cars do
    cars = ENV.fetch('cars', nil).to_i
    db = Lib::Models::DataBase.new(PATH_TO_DB)
    cars.times { db.create_car(APPEND, PATH_TO_DB) }
  end
end
