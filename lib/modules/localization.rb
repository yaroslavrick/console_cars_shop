module Lib
  module Modules
    module Localization
      def localize(key)
        I18n.t(key)
      end
    end
  end
end
