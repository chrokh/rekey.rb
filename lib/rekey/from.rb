module Rekey
  class From

    def initialize key
      @key = key
    end

    def rekey obj
      obj[@key]
    end

    def unkey obj
      obj.map do |key, value|
        if key == @key
          {}
        else
          Hash[key, value]
        end
      end.reduce({}, &:merge)
    end

  end
end
