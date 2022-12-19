# frozen_string_literal: true

WRITE = 'w'
APPEND = 'a'
CURRENT_PATH = File.dirname(__FILE__)
PATH_TO_DB = File.join(CURRENT_PATH, '../db/db.yml').freeze
PATH_TO_DB_BACKUP = File.join(CURRENT_PATH, '../db/db_backup.yml').freeze

namespace :database do
  namespace :cars do
    desc 'Add cars to database (for example: rake database:add cars=3 or just: rake database:add)'
    task :add do
      # rubocop:disable Style/RedundantFetchBlock
      cars = ENV.fetch('cars') { 1 }.to_i
      # rubocop:enable Style/RedundantFetchBlock
      db = Lib::Models::DataBase.new
      cars.times { db.create_car(APPEND, PATH_TO_DB) }
    end

    desc 'Clear whole database'
    task :clear do
      db = Lib::Models::DataBase.new
      db.save(nil, WRITE, PATH_TO_DB)
    end

    desc 'Restore database'
    task :restore do
      db = Lib::Models::DataBase.new
      backup = db.load(PATH_TO_DB_BACKUP)
      db.save(backup, WRITE, PATH_TO_DB)
    end
  end
end
