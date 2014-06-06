require 'rspec'
require_relative '../mastermind'
require_relative '../board'
require_relative '../guess'

module Helpers
  # Replace standard input with faked one StringIO. 
  def fake_stdin(*args)
    begin
      $stdin = StringIO.new
      $stdin.puts(args.shift) until args.empty?
      $stdin.rewind
      yield
    ensure
      $stdin = STDIN
    end
  end
end
