# Boxxer

This gem intended to pick containers(boxes, packages, cartons), based on item weights

## Usage

```
gem install boxxer
irb
```

```
require 'securerandom'
require 'boxxer'
contents = 20.times.with_object([]) { |_, obj| obj.push(item: SecureRandom.alphanumeric(10), weight: rand(0.5..1).round(3)) }
containers = [{ length: 47, width: 38, height: 10, tare_weight: 0.019, net_limit: 0.481 },
              { length: 40, width: 28, height: 13, tare_weight: 0.34, net_limit: 0.66 },
              { length: 40, width: 28, height: 80, tare_weight: 0.1, net_limit: 0.7 },
              { length: 40, width: 28, height: 18, tare_weight: 0.5, net_limit: 1.5 },
              { length: 40, width: 28, height: 20, tare_weight: 0.52, net_limit: 2.48 }]
boxxer = Boxxer.call(containers: containers, contents: contents)
```
