require "test_helper"

class Minitest::NoAssertionsTest < Minitest::Test
  attr_accessor :reporter

  def setup
    self.reporter = Minitest::CompositeReporter.new
    self.reporter << Minitest::NoAssertions::Reporter.new($stdout)
  end

  def test_detect_no_assertions_test
    e = assert_raises StandardError do
      Minitest::Runnable.run_one_method(DummyTest, :no_assertion, reporter)
    end

    assert_equal "DummyTest#no_assertion has no assertions!!", e.message
  end

  def test_respect_original_exception
    Minitest::Runnable.run_one_method(DummyTest, :exception, reporter)
    assert true
  end
end

class DummyTest < Minitest::Test
  def no_assertion
  end

  def exception
    raise "Exception!"
  end
end
