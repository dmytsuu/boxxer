require 'boxxer/container'
require 'boxxer/content'
require 'boxxer/version'

module Boxxer
  class Error < StandardError; end

  class Arranger
    attr_reader :contents, :containers

    def initialize(weights, containers)
      assign_contents(weights)
      @containers = containers
    end

    def contents_weight
      @contents_weight ||= contents.sum(&:weight).to_f
    end

    def max_limit
      containers.find { |container| container[:limit] }[:limit]
    end

    def containers_required
      (contents_weight / max_limit).ceil
    end

    private

    def assign_contents(weights)
      @contents = weights.sort.reverse.map { |weight| Content.new(weight) }
    end
  end
end
