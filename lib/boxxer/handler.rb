require 'boxxer/container'

module Boxxer
  class Handler
    attr_reader :containers

    def initialize(containers:, weights:)
      @available_containers = containers.sort { |container| container[:net_limit] }.reverse
      @largest_container = @available_containers.last
      @weights = weights.sort.reverse
      @containers = []
    end

    def call
      raise Error, "Largest container net_limit is #{@largest_container[:net_limit]}, but maximum weight is #{@weights.max}" if invalid_options?
      until @weights.empty? do
        container = Container.new(matching_container)
        complete_container(container)
        @containers << container
      end
      self
    end

    def total_gross_weight
      @containers.sum(&:gross_weight).truncate(3)
    end

    def total_net_weight
      @containers.sum(&:net_weight).truncate(3)
    end

    def container_count
      @containers.count
    end

    private

    def complete_container(container)
      loop do
        fittable_weight = @weights.find { |weight| container.fittable?(weight) }
        fittable_weight.nil? ? break : container.add_weight(@weights.delete_at(@weights.index(fittable_weight)))
      end
    end

    def invalid_options?
      @weights.max > @largest_container[:net_limit]
    end

    def matching_container
      @available_containers.find { |container| container[:net_limit] >= @weights.sum } || @largest_container
    end
  end
end