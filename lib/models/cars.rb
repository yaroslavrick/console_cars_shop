module Lib
  module Models
    class Cars < DataBase
      def load
        YAML.safe_load(File.read("#{CURRENT_PATH}/../db/#{db_name}"))
      end
      
      def save
        # todo
      end
    end
  end
end