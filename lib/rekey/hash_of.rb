module Rekey
  class HashOf < Rekey::From

    def initialize key, schema
      @key = key
      @schema = schema
    end

    def rekey obj
      obj[@key]
        .map { |key, value| Hash[key, @schema.rekey(value)] }
        .reduce({}, &:merge)
    end

  end
end
