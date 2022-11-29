# frozen_string_literal: true

module Lib
  class Console
    include Lib::Modules::InputOutput
    include Lib::Modules::Validation
    include Lib::Modules::Localization
    include Lib::Modules::Colorize

    attr_reader :database, :total_requests, :result_data, :search_rules

    def initialize
      @database = Lib::DataBase.new
    end

    def call
      loop do
        search
        print_result
        save_to_log
        break if exit?
      end
    end

    def show_prettified_result(result_data)
      return puts colorize_title(localize('results.empty')) if result_data.empty?

      result_data.each do |car|
        localize_rows(car)
        rows = car.map do |key, value|
          [colorize_main(key.to_s), colorize_result(value.to_s)]
          # [key.to_s.colorize(MAIN_COLOR), value.to_s.colorize(RESULT_COLOR)]
        end
        create_table('results.title', 'results.params', 'results.data', rows)
      end
    end

    private

    def search
      @search_rules = ask_cars_fields
      validate_user_input(search_rules)
      @result_data = Lib::SearchEngineQuery.new(data: database.load.clone,
                                                params: search_rules).call
    end

    def find_total_requests
      @total_requests = Lib::Statistics.new(rules: search_rules,
                                            searches_history: database.load_log).find_identical_requests
    end

    def print_result
      find_total_requests
      show_prettified_result(result_data)
      show_prettified_statistic
    end

    def save_to_log
      database.save_log(search_rules, total_requests, result_data.count)
    end

    def ask_cars_fields
      input_data = %i[make model year_from year_to price_from price_to].each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      input_data[:sort_option] = ask_field('sort option (date_added|price)')
      input_data[:sort_direction] = ask_field('sort direction (desc|asc)')
      input_data
    end

    def validate_user_input(params)
      fields_valid = field_less_then(params[:year_from],
                                     params[:year_to]) && field_less_then(params[:price_from],
                                                                          params[:price_to])
      raise(localize('errors.wrong_field')) unless fields_valid

      fields_valid
    end

    def show_prettified_statistic
      rows = [[colorize_main(localize('statistics.total_quantity')), colorize_result(result_data.count.to_s)],
              [colorize_main(localize('statistics.requests_quantity')), colorize_result(total_requests.to_s)]]
      create_table('statistics.statistic', 'statistics.title', 'statistics.number', rows)
    end

    def create_table(title_name, first_header, second_header, rows)
      table = Terminal::Table.new(
        title: colorize_title(localize(title_name)),
        headings: [colorize_header(localize(first_header)),
                   colorize_header(localize(second_header))],
        rows: rows
      )
      table.style = TABLE_STYLE
      puts table
    end

    def localize_rows(car)
      car.transform_keys! do |key|
        localize("table.#{key}")
      end
    end
  end
end
