# frozen_string_literal: true

module Lib
  class Console
    include Lib::Modules::InputOutput
    include Lib::Modules::Validation
    include Lib::Modules::Localization
    include Lib::Modules::Colorize
    SEARCH_RULES_OPTIONS = %i[make model year_from year_to price_from price_to].freeze

    attr_reader :total_requests, :result_data, :search_rules, :statistics_db, :cars_db, :user_searches, :user_email

    def initialize
      @statistics_db = Lib::Models::Statistics.new
      @cars_db = Lib::Models::Cars.new
      # @user_searches = Lib::Models::UserSearches.new
    end

    def call(status: false, email: nil)
      @auth_status = status
      @user_email = email
      loop do
        search
        update_statistics
        add_user_searches
        print_result
        break if exit?
      end
    end

    def show_prettified_result(result_data)
      return puts colorize_title(localize('results.empty')) if result_data.empty?

      result_data.each do |car|
        localize_rows(car)
        rows = car.map do |key, value|
          [colorize_main(key.to_s), colorize_result(value.to_s)]
        end
        create_table('results.title', 'results.params', 'results.data', rows)
      end
    end

    private

    def add_user_searches
      return unless @auth_status

      @user_searches = Lib::Models::UserSearches.new(email: @user_email).update(rules: search_rules[:search_rules])
    end

    def search
      ask_cars_fields
      validate_user_input(search_rules[:search_rules])
      @result_data = Lib::SearchEngineQuery.new(data: cars_db.load.clone,
                                                params: search_rules).call
    end

    def update_statistics
      statistics_db.update(search_rules[:search_rules])
    end

    def print_result
      @total_requests = statistics_db.find_total_requests(search_rules[:search_rules])
      show_prettified_result(result_data)
      show_prettified_statistic
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

    def save_to_log
      database.save_log(search_rules, total_requests, result_data.count)
    end

    def ask_cars_fields
      initialize_search_rules
      search_rules[:search_rules] = SEARCH_RULES_OPTIONS.each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      search_rules[:sort_rules][:sort_option] = ask_field('sort option (date_added|price)')
      search_rules[:sort_rules][:sort_direction] = ask_field('sort direction (desc|asc)')
      # search_rules[:user] = user_email
    end

    def initialize_search_rules
      @search_rules = {
        search_rules: {},
        sort_rules: {
          sort_option: nil,
          sort_direction: nil
        }
      }
    end

    def validate_user_input(params)
      fields_valid = field_less_then(params[:year_from],
                                     params[:year_to]) && field_less_then(params[:price_from],
                                                                          params[:price_to])

      raise localize('errors.wrong_field') unless fields_valid

      fields_valid
    end
  end
end
