require 'boxxer/handler'
require 'boxxer/version'

module Boxxer
  class Error < StandardError; end

  def self.call(options = {})
    Handler.new(options).call
  end
end
