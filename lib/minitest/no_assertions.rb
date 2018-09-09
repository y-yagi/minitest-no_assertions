require "minitest/no_assertions/version"
require "minitest"

module Minitest
  module NoAssertions
    class << self
      def behavior=(behavior)
        @behavior = behavior
      end

      def behavior
        defined?(@behavior) ? @behavior : nil
      end
    end

    class Reporter < Minitest::StatisticsReporter
      def initialize(io = $stdout, options = {})
        super(io, options)
      end

      def record(result)
        if result.passed? && result.assertions.zero?
          msg = "%s has no assertions!!" % [result.location]
          warn(msg)
        end
      end

      private

      def warn(msg)
        if Minitest::NoAssertions.behavior == :stderr
          $stderr.puts(msg)
        else
          raise msg
        end
      end
    end
  end
end
