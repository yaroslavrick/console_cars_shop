# frozen_string_literal: true

module Lib
  module Models
    class DataBase
      # include Lib::Misc::Constants::DataBaseFilenames
      CURRENT_PATH = File.dirname(__FILE__)
      DATABASE = 'db.yml'
      LOG_FILE = File.join(CURRENT_PATH, '../db/searches.yml').freeze
      USERS_LOGINS_AND_PASSWORDS_FILE = File.join(CURRENT_PATH, '../db/users.yml').freeze
      USER_SEARCHES_FILE = File.join(CURRENT_PATH, '../db/user_searches.yml').freeze
      DB_FILE = File.read("#{CURRENT_PATH}/../db/db.yml").freeze
      WRITE = 'w'
      APPEND_PLUS = 'a+'
      APPEND = 'a'
      attr_reader :db_name

      def initialize(db = DATABASE)
        @db_name = db
      end

      def find(search_rules)
        searches_data.find { |car| car[:rules] == search_rules }
      end

      def find_total_requests(search_rules)
        match_requests = find(search_rules)
        return match_requests[:stats][:requests_quantity] if match_requests

        1
      end

      def increase_quantity(search_rules)
        searches_data.map! do |data|
          data[:stats][:requests_quantity] += 1 if data[:rules] == search_rules
          data
        end
      end

      def save(data, write_type, filepath)
        entry = data.to_yaml.gsub("---\n", '')
        file = File.open(File.expand_path(filepath), write_type)
        file.puts(entry)
        file.close
      end

      def load(filepath)
        YAML.load_file(filepath)
      end

      def create_car(write_type, filepath)
        car = generate_car
        save(car, write_type, filepath)
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

      # def save(log = LOG_FILE)
      #   entry = searches_data.to_yaml.gsub("---\n", '')
      #   file = File.open(File.expand_path(log), WRITE)
      #   file.puts(entry)
      #   file.close
      # end

      private

      def open_file(file, flag)
        File.open(File.expand_path(file), flag)
      end
    end
  end
end
