module Boxxer
  class Container
    attr_reader :tare_weight, :net_weight, :gross_weight, :weidth, :height, :length
    attr_writer :weights

    def initialize(width:, height:, length:, tare_weight:, net_limit:)
      @width = width
      @height = height
      @length = length
      @net_limit = net_limit
      @tare_weight = tare_weight
      @weights = []
    end

    def net_weight
      (@weights.sum).truncate(3)
    end

    def gross_weight
      (net_weight + @tare_weight).truncate(3)
    end

    def fittable?(weight)
      @net_limit >= net_weight + weight
    end

    def add_weight(weight)
      @weights.push(weight)
    end
  end
end
