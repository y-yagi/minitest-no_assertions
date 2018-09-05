require "test_helper"

class Minitest::NoAssertionsTest < Minitest::Test
  attr_accessor :reporter

  def setup
    self.reporter = Minitest::CompositeReporter.new
    self.reporter << Minitest::NoAssertions::Reporter.new($stdout)
  end

  def test_detect_no_assertions_test
    e = assert_raises StandardError do
      Minitest::Runnable.run_one_method(DummyTest, :fail, self.reporter)
    end

    assert_equal "DummyTest#fail has no assertions!!", e.message
  end
end

class DummyTest < Minitest::Test
  def fail
  end
end
