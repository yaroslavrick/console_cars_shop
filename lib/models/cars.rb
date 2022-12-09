module Lib
  module Models
    class Cars < DataBase
      def load(db = DB_FILE)
        YAML.safe_load(db)
      end
    end
  end
end
