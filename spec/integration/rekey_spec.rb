require 'rekey/rekey'
require 'rekey/from'
require 'rekey/array_of'
require 'rekey/schema'

describe Rekey, '.rekey' do

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

  it 'rekeys' do
    actual = Rekey.rekey(before, schema)
    expect(actual).to eq after
  end

end





