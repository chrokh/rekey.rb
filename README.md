# rekey.rb

Rename keys of deeply nested hash based on schema.

Assume we have the following hash...

```ruby
bad = { posts: [{ id: 11, comments: [{ id: 22, author: 44 }] }] }
```

...and we want to rename `:posts` => `:articles`, `:comments` => `:opinions`, and `:author` => `:writer`, so that we instead get the following hash...

```ruby
good = { articles: [{ id: 11, opinions: [{ id: 22, writer: 44 }] }] }
```

We then construct the following schema...

```ruby
schema = Schema.new({
  articles: ArrayOf.new(:posts, Schema.new({
    opinions: ArrayOf.new(:comments, Schema.new({
      writer: From.new(:author)
    }))
  }))
})
```

...then we can move from the input structure to the output structure by calling...

```ruby
schema.rekey(obj)

# Or like this..
Rekey.rekey(obj, schema)
```

Either way, it means that...

```ruby
schema.rekey(bad) == good
```

...by the way I assumed we have required and included like this...

```ruby
require 'rekey/rekey'
require 'rekey/from'
require 'rekey/array_of'
require 'rekey/schema'

include Rekey
```







## API

### `Rekey::Schema`

To rekey you must start with a Schema.

`#new(definition)`

When instantiating a schema you must pass a definition. The definition is a hash. The keys of the definition are the keys you wish to extract and the values are rekey schemas.

### `Rekey::From < Rekey::Schema`

When you only want to rename a key you use From.

`#new(key)`

When instantiating the From schema, pass the name of the key you want to rename **from**.


### `Rekey::ArrayOf`

When you are extracting from an array use ArrayOf.

`#new(key, schema)`

When instantiating an array schema you must pass the key **from** which you want to extract the array, and the schema you want to run over all the values.





## License

The MIT License (MIT) Copyright (c) 2016 Christopher Okhravi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
