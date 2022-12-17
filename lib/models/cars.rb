# frozen_string_literal: true

module Lib
  module Models
    class Cars < DataBase
      include Lib::Modules::Constants::FilePaths

      def load(db = DB_FILE)
        YAML.safe_load(db)
      end
    end
  end
end
