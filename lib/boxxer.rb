require 'boxxer/container'
require 'boxxer/version'

module Boxxer
  class Error < StandardError; end

  class Arranger
    attr_reader :containers

    def initialize(containers:, weights:)
      @available_containers = containers.sort { |container| container[:limit] }.reverse
      @largest_container = @available_containers.last
      @weights = weights.sort.reverse
      @containers = []
    end

    def call
      raise Error, "Largest container limit is #{@largest_container[:limit]}, but maximum weight is #{@weights.max}" unless valid_options?
      until @weights.empty? do
        container = Container.new(matching_container)
        complete_container(container)
        @containers << container
      end
    end

    private

    def conmplete_container(container)
      loop do
        fittable_weight = @weights.find { |weight| container.fittable?(weight) }
        fittable_weight.nil? ? break : container.add_weight(@weights.delete_at(@weights.index(fittable_weight)))
      end
    end

    def valid_options?
      @largest_container[:limit] >= @weights.max
    end

    def max_weight
      @weights.sum
    end

    def matching_container
      @available_containers.find { |container| container[:limit] >= max_weight } || @largest_container
    end
  end
end
