# frozen_string_literal: true

module Lib
  module Models
    class DataBase
      include Lib::Modules::Constants::ReadWriteType
      include Lib::Modules::Constants::FilePaths
      include Lib::Modules::Constants::DateConst

      attr_reader :id

      def find(search_rules, searches_data)
        searches_data.find { |car| car[:rules] == search_rules }
      end

      def find_total_requests(search_rules)
        all_users_searches_data = load(LOG_FILE)
        match_requests = find(search_rules, all_users_searches_data)
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
        file = open_file(filepath, write_type)
        file.puts(entry)
        file.close
      end

      def load(filepath = DB_FILE)
        create_file(filepath) unless File.exist?(filepath)

        YAML.load_file(filepath) || []
      end

      def create_fake_car(write_type, filepath)
        car = generate_fake_car
        save(car, write_type, filepath)
      end

      def create_car(write_type:, filepath:, params:)
        car = generate_car(params)
        @id = car[0]['id']
        save(car, write_type, filepath)
      end

      private

      def generate_fake_car
        [{ 'id' => FFaker::Vehicle.vin,
           'make' => FFaker::Vehicle.make,
           'model' => FFaker::Vehicle.model,
           'year' => FFaker::Vehicle.year.to_i,
           'odometer' => FFaker::Random.rand(1..300_000),
           'price' => FFaker::Random.rand(1000..500_00).to_i,
           'description' => FFaker::Lorem.phrase,
           'date_added' => FFaker::Time.date }]
      end

      def generate_car(params)
        [{
          'id' => FFaker::Vehicle.vin,
          'make' => params[:make],
          'model' => params[:model],
          'year' => params[:year].to_i,
          'odometer' => params[:odometer].to_i,
          'price' => params[:price].to_i,
          'description' => params[:description],
          'date_added' => Date.today.strftime(DATE_FORMAT)
        }]
      end

      def create_file(filepath)
        File.new(filepath.to_s, WRITE_PLUS)
      end

      def open_file(file, flag)
        File.open(File.expand_path(file), flag)
      end
    end
  end
end
