require "minitest/no_assertions"

module Minitest
  def self.plugin_no_assertions_init(opts)
    self.reporter << Minitest::NoAssertions::Reporter.new($stdout, opts)
  end
end
