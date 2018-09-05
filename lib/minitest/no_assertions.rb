require "minitest/no_assertions/version"
require "minitest"

module Minitest
  module NoAssertions
    class Reporter < Minitest::StatisticsReporter
      def initialize(io = $stdout, options = {})
        super(io, options)
      end

      def record(result)
        if result.assertions.zero?
          msg = "%s#%s has no assertions!!" % [result.klass, result.name]
          raise StandardError, msg
        end
      end
    end
  end
end
