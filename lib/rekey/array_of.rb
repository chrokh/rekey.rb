module Rekey
  class ArrayOf < Rekey::From

    def initialize key, schema
      @key = key
      @schema = schema
    end

    def rekey obj
      obj[@key].map { |value| @schema.rekey(value) }
    end

  end
end
