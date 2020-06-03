module Boxxer
  class Conteiner
    attr_reader :width
    attr_reader :height
    attr_reader :length
    attr_reader :contents
    attr_reader :tare_weight
    attr_reader :contents_weight
    attr_reader :total_weight

    def initialize(limit)
      @limit = limit
    end

    def contents_weight
      contents.sum(&:weight)
    end

    def total_weight
      contents_weight + tare_weight
    end
  end
end
