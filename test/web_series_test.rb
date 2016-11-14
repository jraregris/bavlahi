require './test/test_helper'

require './lib/web_series'

describe WebSeries do
  describe 'slug' do
    it 'should be based on title' do
      ws = WebSeries.new('test', nil, nil)
      ws.slug.must_equal('test')
    end

    it 'should replace space with dash' do
      ws = WebSeries.new('test test', nil, nil)
      ws.slug.must_equal('test-test')
    end

    it 'should be all downcased' do
      ws = WebSeries.new('AbCdEfG', nil, nil)
      ws.slug.must_equal('abcdefg')
    end
  end
end
