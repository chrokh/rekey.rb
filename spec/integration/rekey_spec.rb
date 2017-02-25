require 'rekey/rekey'
require 'rekey/from'
require 'rekey/array_of'
require 'rekey/hash_of'
require 'rekey/schema'

include Rekey

describe Rekey do

  let(:before) {
    {
      posts: [
        {
          id: 11,
          comments: {
            22 => {
              id: 22,
              author: 44
            }
          }
        }
      ]
    }
  }

  let(:after) {
    {
      articles: [
        {
          id: 11,
          opinions: {
            22 => {
              id: 22,
              writer: 44
            }
          }
        }
      ]
    }
  }

  let(:schema) {
    Schema.new({
      articles: ArrayOf.new(:posts, Schema.new({
        opinions: HashOf.new(:comments, Schema.new({
          writer: From.new(:author)
        }))
      }))
    })
  }

  it 'can rekey by passing schema to the lib' do
    expect(Rekey.rekey(before, schema)).to eq after
  end

  it 'can rekey by calling rekey on schema' do
    expect(schema.rekey(before)).to eq after
  end

end





