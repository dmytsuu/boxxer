module Boxxer
  class Container
    attr_reader :dimensions
    attr_reader :tare_weight
    attr_reader :net_weight
    attr_reader :gross_weight
    attr_writer :weights

    def initialize(width:, height:, length:, tare_weight:, limit:)
      @width = width
      @height = height
      @length = length
      @limit = limit
      @tare_weight = tare_weight
      @weights = []
    end

    def dimensions
       { width: width, height: height, length: length }
    end

    def net_weight
      @weights.sum
    end

    def gross_weight
      (net_weight + @tare_weight).round(2)
    end

    def fittable?(weight)
      @limit >= net_weight + weight
    end

    def add_weight(weight)
      @weights.push(weight)
    end
  end
end
