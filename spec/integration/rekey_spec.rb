require 'rekey/rekey'
require 'rekey/from'
require 'rekey/array_of'
require 'rekey/schema'

describe Rekey do

  From = Rekey::From
  ArrayOf = Rekey::ArrayOf
  Schema = Rekey::Schema

  let(:before) {
    {
      posts: [
        {
          id: 11,
          comments: [
            {
              id: 22,
              author: 44
            }
          ]
        }
      ]
    }
  }

  let(:after) {
    {
      articles: [
        {
          id: 11,
          opinions: [
            {
              id: 22,
              writer: 44
            }
          ]
        }
      ]
    }
  }

  let(:schema) {
    Schema.new({
      articles: ArrayOf.new(:posts, Schema.new({
        opinions: ArrayOf.new(:comments, Schema.new({
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





