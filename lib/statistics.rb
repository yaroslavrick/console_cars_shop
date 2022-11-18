module Lib
  class Statistics
    attr_reader :data, :rules, :searches_history

    def initialize(data:, rules:, searches_history:)
      @data = data
      @rules = rules
      @searches_history = searches_history
    end

    def call
      add_statistics
      identical_requests
    end

    private

    def add_statistics
      rules[:stats][:requests_quantity] = 1
      rules[:stats][:total_quantity] = data.count
      rules
    end

    def identical_requests
      searches_history.count { |request| request[:rules] == rules[:rules] } + 1
    end
  end
end
