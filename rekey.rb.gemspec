Gem::Specification.new do |s|
  s.name        = 'rekey.rb'
  s.version     = '0.0.1'
  s.summary     = "Rename keys of deeply nested hash based on schema"
  s.authors     = ["Christopher Okhravi"]
  s.files       = [
    "lib/rekey/rekey.rb",
    "lib/rekey/schema.rb",
    "lib/rekey/array_of.rb",
    "lib/rekey/from.rb",
  ]
  s.homepage    = 'https://github.com/chrokh/rekey.rb'
  s.license     = 'MIT'
end
