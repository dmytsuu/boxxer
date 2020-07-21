require 'boxxer/container'

module Boxxer
  class Handler
    attr_reader :containers

    def initialize(containers:, contents:)
      @available_containers = containers.sort_by { |container| container[:net_limit] }
      @largest_container = @available_containers.last
      @contents = contents.sort_by { |content| content[:weight] }.reverse
      @containers = []
    end

    def call
      raise Error, "Largest container net_limit is #{@largest_container[:net_limit]}, but maximum weight is #{content_max_weight}" if invalid_options?

      until @contents.empty? do
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
        fittable_conteiner = @contents.find { |content| container.fittable?(content[:weight]) }
        fittable_conteiner.nil? ? break : container.add_content(@contents.delete_at(@contents.index(fittable_conteiner)))
      end
    end

    def content_max_weight
      @contents.max { |c| c[:weight] }
    end

    def invalid_options?
      content_max_weight[:weight] > @largest_container[:net_limit]
    end

    def matching_container
      @available_containers.find { |container| container[:net_limit] >= @contents.sum { |content| content[:weight] } } || @largest_container
    end
  end
end
