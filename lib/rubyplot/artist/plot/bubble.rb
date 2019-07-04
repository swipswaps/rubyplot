module Rubyplot
  module Artist
    module Plot
      class Bubble < Artist::Plot::Base
        # Width in pixels of the border of each bubble.
        attr_reader :border_width
        attr_reader :z_max, :z_min
        def initialize(*)
          super
          @bubbles = []
          @border_width = 1.0
        end

        def data x_values, y_values, z_values
          super(x_values, y_values)
          @data[:z_values] = z_values
        end

        def draw
          @data[:x_values].each_with_index do |_, idx|
            Rubyplot::Artist::Circle.new(
              self,
              x: @data[:x_values][idx],
              y: @data[:y_values][idx],
              radius: @data[:z_values][idx],
              fill_opacity: 0.5,
              color: @data[:color],
              border_width: 1,
              abs: false
            ).draw
          end
        end
      end # class Bubble
    end # module Plot
  end # module Artist
end # module Rubyplot
