module Rekey
  class Schema

    def initialize definition
      @definition = definition
    end

    def rekey obj
      additions = @definition.keys.map do |key|
        value = @definition[key].rekey(obj)
        Hash[key, value]
      end.reduce({}, &:merge)

      unkeyed = @definition.keys.reduce(obj) do |acc, key|
        @definition[key].unkey(acc)
      end

      unkeyed = @definition.keys.map do |key|
        value = @definition[key].unkey(obj)
      end.reduce({}, &:merge)

      unkeyed.merge(additions)
    end

  end
end
