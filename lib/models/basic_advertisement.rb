# frozen_string_literal: true

module Lib
  module Models
    class BasicAdvertisement
      include Lib::Modules::InputOutput
      include Lib::Modules::Colorize
      include Lib::Modules::Constants::ReadWriteType
      include Lib::Modules::Constants::FilePaths
      include Lib::Modules::Constants::RegExps
      include Lib::Modules::Constants::ParamsConst
    end
  end
end
