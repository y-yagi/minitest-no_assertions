require "test_helper"

class Minitest::NoAssertionsTest < Minitest::Test
  attr_accessor :reporter

  def setup
    self.reporter = Minitest::CompositeReporter.new
    self.reporter << Minitest::NoAssertions::Reporter.new($stdout)
  end

  def test_detect_no_assertions_test
    e = assert_raises StandardError do
      fail_test = Class.new(Minitest::Test) do
        def fail
        end
      end
      Minitest::Runnable.run_one_method(fail_test, :fail, self.reporter)
    end

    assert_equal "Minitest::Result#fail has no assertions!!", e.message
  end
end
