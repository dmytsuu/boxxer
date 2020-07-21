module Boxxer
  class Container
    attr_reader :tare_weight, :width, :height, :length
    attr_accessor :contents

    def initialize(width:, height:, length:, tare_weight:, net_limit:)
      @width = width
      @height = height
      @length = length
      @net_limit = net_limit
      @tare_weight = tare_weight
      @contents = []
    end

    def net_weight
      @contents.sum { |content| content[:weight] }.truncate(3)
    end

    def gross_weight
      (net_weight + @tare_weight).truncate(3)
    end

    def fittable?(weight)
      @net_limit >= net_weight + weight
    end

    def add_content(content)
      @contents.push(content)
    end
  end
end
