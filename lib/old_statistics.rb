module Lib
  class Statistics
    attr_reader :rules, :searches_history

    def initialize(rules:, searches_history:)
      @rules = rules
      @searches_history = searches_history
    end

    def find_identical_requests
      searches_history.count { |request| request[:rules] == rules } + 1
    end
  end
end
