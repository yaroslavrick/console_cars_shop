# frozen_string_literal: true

module Lib
  module Models
    class Cars < DataBase
      def load
        YAML.safe_load(File.read("#{CURRENT_PATH}/../db/#{db_name}"))
      end
    end
  end
end
