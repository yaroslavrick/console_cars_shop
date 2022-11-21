I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
I18n.default_locale = :en
module Lib
  class ::CarsManagement
    include Lib::Modules::InputOutput
    include Lib::Modules::Validation
    include Lib::Modules::Localization
    include Lib::Modules::Colorify

    def initialize
      @database = DataBase.new.load
    end

    def run
      ask_locale
      loop do
        search_rules = ask_cars_fields
        validate_user_input?(search_rules[:rules])
        result_data = Lib::SearchEngineQuery.new(data: @database.clone,
                                                 params: search_rules[:rules]).call
        show_prettified_result(result_data)
        searches_history = DataBase.new.load_log
        requests = Statistics.new(rules: search_rules, searches_history:).identical_requests
        show_prettified_statistic(result_data.count, requests)
        DataBase.new.save_log(search_rules, requests, result_data.count)
        break if exit?
      end
    end

    private

    def ask_locale
      puts 'Choose language: EN/ua: '.colorize(:blue)
      locale = gets.chomp.downcase.to_sym
      I18n.locale = if locale == :ua
                      locale
                    else
                      :en
                    end
    end

    def ask_cars_fields
      input_data = %i[make model year_from year_to price_from price_to].each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      input_data[:sort_option] = ask_field('sort option (date_added|price)')
      input_data[:sort_direction] = ask_field('sort direction (desc|asc)')
      create_query(input_data)
    end

    def validate_user_input?(params)
      fields_valid = field_less_then(params[:year_from],
                                     params[:year_to]) && field_less_then(params[:price_from],
                                                                          params[:price_to])
      raise I18n.t('errors.wrong_field') unless fields_valid

      fields_valid
    end

    def create_query(data)
      {
        rules: {
          make: data[:make],
          model: data[:model],
          year_from: data[:year_from],
          year_to: data[:year_to],
          price_from: data[:price_from],
          price_to: data[:price_to],
          sort_option: data[:sort_option],
          sort_direction: data[:sort_direction]
        },
        stats: {}
      }
    end
  end
end
