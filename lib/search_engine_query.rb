module Lib
  class SearchEngineQuery
    DATE_FORMAT = '%d/%m/%Y'.freeze

    attr_reader :data, :params

    def initialize(data:, params:)
      @data = data
      @params = params
    end

    def call
      search
      sort
    end

    private

    def search
      search_by(params[:make], 'make')
      search_by(params[:model], 'model')
      search_by_range(params[:price_from], params[:price_to], 'price')
      search_by_range(params[:year_from], params[:year_to], 'year')
    end

    def search_by(rule, option)
      return data if rule.empty?

      data.keep_if { |car| car[option].casecmp(rule).zero? }
    end

    def search_by_range(from, to, rule)
      return if data.empty?

      max_value = data.max_by { |car| car[rule] }
      to = max_value[rule] unless to.is_a?(Integer)
      data.keep_if { |car| car[rule].between?(from.to_i, to.to_i) }
    end

    def sort_by_option(sort_option)
      return data.sort_by { |car| car['price'] } if sort_option.casecmp('price').zero?

      data.sort_by { |car| Date.strptime(car['date_added'], DATE_FORMAT) }
    end

    def sort_by_direction(sort_direction)
      return data if sort_direction.casecmp('asc').zero?

      data.reverse
    end

    def sort
      sort_by_option(params[:sort_option])
      sort_by_direction(params[:sort_direction])
    end
  end
end
