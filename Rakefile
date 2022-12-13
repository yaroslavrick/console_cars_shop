# frozen_string_literal: true

require 'yaml'
require 'ffaker'
require 'faker'
require 'date'
require_relative './lib/models/database.rb'

WRITE = 'w'
APPEND = 'a'
# PATH_TO_DB = './lib/db/db.yml'
# PATH_TO_DB_BACKUP = './lib/db/db_backup.yml'
CURRENT_PATH = File.dirname(__FILE__)
PATH_TO_DB = File.join(CURRENT_PATH, './lib/db/db.yml')
PATH_TO_DB_BACKUP = File.join(CURRENT_PATH, './lib/db/db_backup.yml')

# def generate_car
#   [{
#     'id' => Faker::Base.numerify('########-####-####-####-############'),
#     'make' => FFaker::Vehicle.make,
#     'model' => FFaker::Vehicle.model,
#     'year' => FFaker::Vehicle.year.to_i,
#     'odometer' => Faker::Vehicle.kilometrage,
#     'price' => Faker::Commerce.price(range: 1500..100_000, as_string: false).to_i,
#     'description' => Faker::Vehicle.standard_specs.join,
#     'date_added' => Date.today.strftime('%d/%m/%Y')
#   }]
# end

# def save(data, write_type, filepath)
#   entry = data.to_yaml.gsub("---\n", '')
#   file = File.open(File.expand_path(PATH_TO_DB), write_type)
#   file.puts(entry)
#   file.close
# end

# def load(filepath)
#   YAML.load_file(filepath)
# end

namespace :work_with_database do
  desc 'Clear whole database'
  task :clear_whole_database do
    db = Lib::Models::DataBase.new(PATH_TO_DB)
    backup = db.load(PATH_TO_DB)
    db.save(nil, WRITE, PATH_TO_DB)
  end

  desc 'Restore database'
  task :restore_database do
    db = Lib::Models::DataBase.new(PATH_TO_DB_BACKUP)
    backup = db.load(PATH_TO_DB_BACKUP)
    db.save(backup, WRITE, PATH_TO_DB_BACKUP)
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
