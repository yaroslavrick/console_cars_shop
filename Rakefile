# frozen_string_literal: true

require 'yaml'
require 'ffaker'
require 'faker'
require 'date'

WRITE = 'w'
APPEND = 'a'
PATH_TO_DB = './lib/db/db.yml'
PATH_TO_DB_BACKUP = './lib/db/db_backup.yml'

def create_car(write_type)
  car = generate_car
  add_to_db(car, write_type)
end

def generate_car
  [{
    'id' => Faker::Base.numerify('########-####-####-####-############'),
    'make' => FFaker::Vehicle.make,
    'model' => FFaker::Vehicle.model,
    'year' => FFaker::Vehicle.year.to_i,
    'odometer' => Faker::Vehicle.kilometrage,
    'price' => Faker::Commerce.price(range: 1500..100_000, as_string: false).to_i,
    'description' => Faker::Vehicle.standard_specs.join,
    'date_added' => Date.today.strftime('%d/%m/%Y')
  }]
end

def add_to_db(car, write_type)
  entry = car.to_yaml.gsub("---\n", '')
  file = File.open(File.expand_path(PATH_TO_DB), write_type)
  file.puts(entry)
  file.close
end

def load(filepath)
  YAML.load_file(filepath)
end

namespace :work_with_database do
  desc 'Clear whole database'
  task :clear_whole_database do
    add_to_db(nil, WRITE)
  end

  desc 'Restore database'
  task :restore_database do
    backup = load(PATH_TO_DB_BACKUP)
    add_to_db(backup, WRITE)
  end
end

namespace :add_to_database do
  desc 'Add a car to database'
  task :add_car do
    create_car('a')
  end

  desc 'Add cars to database'
  task :add_cars do
    cars = ENV.fetch('cars', nil).to_i
    cars.times { create_car(APPEND) }
  end
end
