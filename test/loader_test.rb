require './test/test_helper'

require './lib/loader'

describe Loader do
  it 'should read from the given file' do
    test_io = StringIO.new
    test_io << "---\n:test: testen\n"
    test_io.rewind
    Loader.load_all(test_io).must_equal test: 'testen'
  end
end
