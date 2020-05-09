# lib/check_errors.rb

require_relative('../bin/main.rb')

class ErrorCheck < LintError
  def initialize()
    super
  end
end

testing = ErrorCheck.new

p testing
