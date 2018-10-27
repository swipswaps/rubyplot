module Rubyplot
  class Axes
    attr_accessor :x_title, :y_title, :x_range, :y_range,
                  :x_tick_count, :y_tick_count, :text_font, :grid,
                  :bounding_box, :x_axis_padding, :y_axis_padding, :origin,
                  :title_shift, :title

    attr_reader :figure, :plots

    def initialize
      @x_title = ''
      @y_title = ''
      @x_range = [0, 0]
      @y_range = [0, 0]
      @x_tick_count = :default
      @y_tick_count = :default
      
      @origin = %i[default default]
      @title = nil
      @title_shift = 0
      @text_font = :default
      @grid = true
      @bounding_box = true
      @x_axis_padding = :default
      @y_axis_padding = :default
      @plots = []
    end

    def scatter! *args, &block
      plot = with_backend :scatter, *args
      yield(plot) if block_given?
      @plots << plot
    end

    def write file_name
      @plots[0].write file_name
    end

    private

    def with_backend plot_type, *args
      plot_name = plot_type.to_s.capitalize
      plot =
      case Rubyplot.backend
      when :magick
        Kernel.const_get("Rubyplot::MagickWrapper::Plot::#{plot_name}").new self, *args
      when :gr
        Kernel.const_get("Rubyplot::GRWrapper::Plot::#{plot_name}").new self, *args
      end

      plot
    end
  end # class Axes
end # module Rubyplot