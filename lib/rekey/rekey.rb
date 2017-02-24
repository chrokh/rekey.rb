module Rekey

  def self.rekey obj, schema
    schema.rekey(obj)
  end

end
